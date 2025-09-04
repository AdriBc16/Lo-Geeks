<?php
declare(strict_types=1);
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Use POST']);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true) ?? [];
$topic = trim((string)($input['topic'] ?? ''));
$type  = in_array(($input['type'] ?? ''), ['logic','teoria'], true) ? $input['type'] : 'logic';
$n     = max(1, min(50, (int)($input['n'] ?? 10)));

if ($topic === '') {
    http_response_code(400);
    echo json_encode(['error' => 'Falta topic']);
    exit;
}

$apiKey = getenv('OPENAI_API_KEY');
if (!$apiKey) {
    http_response_code(500);
    echo json_encode(['error' => 'Falta OPENAI_API_KEY']);
    exit;
}

// Esquema de salida estricta (Structured Outputs)
$schema = [
    "type" => "object",
    "properties" => [
        "questions" => [
            "type" => "array",
            "minItems" => $n,
            "maxItems" => $n,
            "items" => [
                "type" => "object",
                "required" => ["prompt","option1","option2","option3","option4","correctIndex"],
                "properties" => [
                    "prompt" => ["type" => "string", "minLength" => 5],
                    "option1" => ["type" => "string"],
                    "option2" => ["type" => "string"],
                    "option3" => ["type" => "string"],
                    "option4" => ["type" => "string"],
                    "correctIndex" => ["type" => "integer", "minimum" => 0, "maximum" => 3]
                ],
                "additionalProperties" => false
            ]
        ]
    ],
    "required" => ["questions"],
    "additionalProperties" => false
];

$prompt = <<<PROMPT
Genera $n preguntas de opción múltiple en español sobre "{$topic}" para el banco "{$type}".
- Usa estilo claro y breve para un nivel universitario.
- EXACTAMENTE 4 opciones por pregunta (option1..option4), sin explicaciones.
- "correctIndex" debe ser 0..3, alineado con la opción correcta.
PROMPT;

$payload = [
    "model" => "gpt-4o-mini",
    "input" => $prompt,
    "max_output_tokens" => 1200,   // controla coste
    "temperature" => 0.4,          // estabilidad
    "response_format" => [
        "type" => "json_schema",
        "json_schema" => [
            "name" => "QuestionsSchema",
            "schema" => $schema,
            "strict" => true
        ]
    ]
];

$ch = curl_init("https://api.openai.com/v1/responses");
curl_setopt_array($ch, [
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_HTTPHEADER => [
        "Content-Type: application/json",
        "Authorization: Bearer {$apiKey}"
    ],
    CURLOPT_POST => true,
    CURLOPT_POSTFIELDS => json_encode($payload)
]);

$response = curl_exec($ch);
$http = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$error = curl_error($ch);
curl_close($ch);

if ($response === false || $http >= 400) {
    http_response_code(500);
    echo json_encode([
        "error" => "Fallo OpenAI",
        "status" => $http,
        "detail" => $error ?: $response
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

$decoded = json_decode($response, true);
$data = $decoded['output'] ?? $decoded['response'] ?? null; // estructura puede variar
if (isset($decoded['output']) && is_array($decoded['output'])) {
    // Responses API suele devolver under `output[0].content[0].text` ó `output[0].content[0].json`
    foreach ($decoded['output'] as $block) {
        if (!empty($block['content'][0]['json'])) {
            $data = $block['content'][0]['json'];
            break;
        }
        if (!empty($block['content'][0]['text'])) {
            $data = json_decode($block['content'][0]['text'], true);
            break;
        }
    }
}

if (!is_array($data) || empty($data['questions'])) {
    http_response_code(500);
    echo json_encode(["error" => "Respuesta inesperada", "raw" => $decoded]);
    exit;
}

// Respuesta final (sin guardar aún)
echo json_encode([
    "type" => $type,
    "count" => count($data['questions']),
    "questions" => $data['questions']
], JSON_UNESCAPED_UNICODE);

//123123123123

// ... después de obtener $data['questions'] y conocer $type:
$pdo = new PDO('mysql:host=localhost;dbname=geek;charset=utf8mb4','tu_user','tu_pass', [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

$table = $type === 'teoria' ? 'teoria_questions' : 'logic_questions';
$sql = "INSERT INTO {$table} (prompt, option1, option2, option3, option4, correctIndex)
        VALUES (:prompt,:o1,:o2,:o3,:o4,:ci)";
$stmt = $pdo->prepare($sql);

$inserted = 0;
foreach ($data['questions'] as $q) {
    $stmt->execute([
        ':prompt' => $q['prompt'],
        ':o1' => $q['option1'],
        ':o2' => $q['option2'],
        ':o3' => $q['option3'],
        ':o4' => $q['option4'],
        ':ci' => (int)$q['correctIndex'],
    ]);
    $inserted++;
}

echo json_encode([
    "type" => $type,
    "inserted" => $inserted
], JSON_UNESCAPED_UNICODE);

