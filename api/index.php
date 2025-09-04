<?php
// Habilitar errores en desarrollo
ini_set('display_errors', 0); // 0 para no mostrar en HTML
error_reporting(E_ALL);

// Capturar cualquier error no controlado y devolver JSON
set_exception_handler(function ($e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Error interno del servidor",
        "debug" => $e->getMessage() // quitar en producción
    ]);
    exit();
});

set_error_handler(function ($errno, $errstr, $errfile, $errline) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Error interno del servidor",
        "debug" => "$errstr en $errfile:$errline" // quitar en producción
    ]);
    exit();
});

// Manejo de preflight para CORS
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
    http_response_code(200);
    exit();
}

// Cabeceras por defecto
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");

// Router básico
$resource = $_GET['resource'] ?? '';

$map = [
    'login' => 'endpoints/login.php',
    'usuario' => 'endpoints/usuario.php',
    'archivo' => 'endpoints/archivo.php',
    'juego' => 'endpoints/juego.php',
    'juego_archivo' => 'endpoints/juego_archivo.php',
    'partida' => 'endpoints/partida.php',
    'puntaje' => 'endpoints/puntaje.php'
];

// Validar y ejecutar el endpoint
if (isset($map[$resource])) {
    include_once $map[$resource];
} else {
    http_response_code(404);
    echo json_encode(["status" => "error", "message" => "Recurso no encontrado"]);
}