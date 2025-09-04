<?php
// Cabeceras para CORS y JSON
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Incluir dependencias (con _DIR_ correcto)
include_once __DIR__ . '/../config/database.php';
include_once __DIR__ . '/../models/Usuario.php';

// Permitir solo POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(["status" => "error", "message" => "Método no permitido."]);
    exit();
}

try {
    // Conexión a la base de datos
    $database = new Database();
    $db = $database->getConnection();
    $usuario = new Usuario($db);

    // Obtener datos del body (JSON)
    $data = json_decode(file_get_contents("php://input"));

    if (empty($data->username) || empty($data->password)) {
        http_response_code(400);
        echo json_encode(["status" => "error", "message" => "Usuario y contraseña son requeridos."]);
        exit();
    }

    // Buscar usuario por username
    $user_data = $usuario->findByUsername($data->username);

    // Validar credenciales
    if ($user_data && isset($user_data['password']) && password_verify($data->password, $user_data['password'])) {
        // Respuesta exitosa
        http_response_code(200);
        unset($user_data['password']); // No enviar hash
        echo json_encode([
            "status" => "success",
            "message" => "Login exitoso.",
            "user" => [
                "id_usuario" => $user_data['id_usuario'],
                "username" => $user_data['username'],
                "nombre" => $user_data['nombre'] ?? '',
                "email" => $user_data['email']
            ]
        ]);
    } else {
        http_response_code(401);
        echo json_encode(["status" => "error", "message" => "Usuario o contraseña incorrectos."]);
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Error interno del servidor.",
        "debug" => $e->getMessage()
    ]);
}
