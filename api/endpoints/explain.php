<?php
declare(strict_types=1);

// === Cabeceras ===
header("Content-Type: application/json; charset=UTF-8");
// Si vas a llamar este endpoint desde web en otro origen, descomenta:
// header("Access-Control-Allow-Origin: *");
// header("Access-Control-Allow-Headers: Content-Type, Authorization");
// header("Access-Control-Allow-Methods: POST, OPTIONS");
// if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { exit; }

// === Config ===
// Usa variable de entorno: export HF_TOKEN="hf_xxx" (o .env con soporte)
$hfToken = getenv('HF_TOKEN');
if (!$hfToken) {
    http_response_code(500);
    echo json_encode(["error" => "Token no configurado en el servidor."]);
    exit;
}

// === Leer body ===
$raw = file_get_contents("php://input");
$input = json_decode($raw, true);

if (
    !is_array($input) ||
    !isset($input['prompt'], $input['selectedOption'], $input['correctOption'])
) {
    http_response_code(400);
    echo json_encode(["error" => "Faltan parámetros: prompt, selectedOption, correctOption."]);
    exit;
}

// === Sanitización básica / límites ===
$prompt  = trim((string)$input['prompt']);
$selected = trim((string)$input['selectedOption']);
$correct  = trim((string)$input['correctOption']);

// Limitar longitudes para evitar abusos (ajusta a tus necesidades)
$maxLen = 2000;
if (strlen($prompt) > $maxLen)   $prompt  = substr($prompt, 0, $maxLen);
if (strlen($selected) > 300)     $selected = substr($selected, 0, 300);
if (strlen($correct) > 300)      $correct  = substr($correct, 0, 300);

// === Construir instrucción al modelo ===
$mensajeIA = "Explica de forma concisa y didáctica por qué la opción '$selected' es incorrecta "
    . "y por qué '$correct' es la correcta, considerando la siguiente pregunta de teoría: '$prompt'. "
    . "Responde en español en 3-5 oraciones.";

// === Payload para HF Inference API ===
// Para modelos text2text (como flan-t5-*) suele ser "generated_text" en la respuesta.
$payload = [
    "inputs" => $mensajeIA,
    "parameters" => [
        "max_new_tokens" => 120,
        "temperature" => 0.7,
        // Evita esperas con reintentos manuales agregando:
        // "repetition_penalty" => 1.1
    ],
    "options" => [
        // Espera a que el modelo cargue si está "cold" (evita 503 intermitente)
        "wait_for_model" => true,
        // Usa caché en inferencias repetidas
        "use_cache" => true
    ]
];

$endpoint = "https://api-inference.huggingface.co/models/google/flan-t5-small";

// === cURL ===
$ch = curl_init($endpoint);
curl_setopt_array($ch, [
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_HTTPHEADER => [
        "Authorization: Bearer {$hfToken}",
        "Content-Type: application/json"
    ],
    CURLOPT_POST => true,
    CURLOPT_POSTFIELDS => json_encode($payload, JSON_UNESCAPED_UNICODE),
    CURLOPT_TIMEOUT => 20,            // timeout total
    CURLOPT_CONNECTTIMEOUT => 10,     // timeout de conexión
    CURLOPT_SSL_VERIFYPEER => true,
    CURLOPT_SSL_VERIFYHOST => 2,
]);

$response = curl_exec($ch);

if ($response === false) {
    $err = curl_error($ch);
    curl_close($ch);
    http_response_code(502);
    echo json_encode(["error" => "Error de red al llamar a Hugging Face", "detail" => $err], JSON_UNESCAPED_UNICODE);
    exit;
}

$httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

// === Manejo de códigos no 2xx ===
if ($httpcode < 200 || $httpcode >= 300) {
    // La API suele enviar JSON con "error"
    $body = json_decode($response, true);
    $detail = is_array($body) && isset($body['error']) ? $body['error'] : $response;
    http_response_code($httpcode);
    echo json_encode([
        "error" => "Error al llamar a Hugging Face",
        "status" => $httpcode,
        "detail" => $detail
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

// === Parsear respuesta ===
$decoded = json_decode($response, true);
$explanation = "No hay explicación disponible.";

// La forma más común: un array de objetos con "generated_text"
if (is_array($decoded)) {
    // Caso: [{"generated_text": "..."}]
    if (isset($decoded[0]['generated_text'])) {
        $explanation = (string)$decoded[0]['generated_text'];
    }
    // Por si algún modelo devolviera otro campo (poco común en text2text)
    elseif (isset($decoded[0]['summary_text'])) {
        $explanation = (string)$decoded[0]['summary_text'];
    }
    // O si devolviera texto plano en el primer elemento
    elseif (isset($decoded[0]) && is_string($decoded[0])) {
        $explanation = $decoded[0];
    }
} elseif (is_string($decoded)) {
    $explanation = $decoded;
}

// Limpieza ligera del output
$explanation = trim($explanation);

// === Respuesta final ===
echo json_encode([
    "explanation" => $explanation,
    "model" => "google/flan-t5-small"
], JSON_UNESCAPED_UNICODE);
