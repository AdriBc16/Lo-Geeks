<?php
header("Content-Type: application/json; charset=UTF-8");
include_once __DIR__ . "/../config/database.php";
include_once __DIR__ . "/../models/Usuario.php";

$database = new Database();
$db = $database->getConnection();
$usuario = new Usuario($db);
// Verificamos qué tipo de preguntas pide el cliente
$type = isset($_GET['type']) ? $_GET['type'] : 'logic';

// Selecciona tabla según tipo
switch ($type) {
    case 'logic':
        $sql = "SELECT id, prompt, option1, option2, option3, option4, correctIndex 
                FROM logic_questions";
        break;
    case 'theory':
        $sql = "SELECT id, prompt, option1, option2, option3, option4, correctIndex 
                FROM teoria_questions";
        break;
    default:
        http_response_code(400);
        echo json_encode(["error" => "Tipo de preguntas no válido"]);
        exit;
}

try {
    $stmt = $db->query($sql);  // Ejecutar con PDO
    $questions = $stmt->fetchAll(PDO::FETCH_ASSOC); // Obtener todas las filas

    echo json_encode($questions, JSON_UNESCAPED_UNICODE);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        "error" => "Error al consultar la base de datos",
        "details" => $e->getMessage()
    ]);
}