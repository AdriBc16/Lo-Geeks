<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Obtener recurso de la URL
$resource = $_GET['resource'] ?? '';
$id = $_GET['id'] ?? null;

// Mapear recursos a sus archivos
$map = [
    'usuario' => 'endpoints/usuario.php',
    'archivo' => 'endpoints/archivo.php',
    'juego' => 'endpoints/juego.php',
    'juego_archivo' => 'endpoints/juego_archivo.php',
    'partida' => 'endpoints/partida.php',
    'puntaje' => 'endpoints/puntaje.php'
];

// Validar recurso
if ($resource && isset($map[$resource])) {
    // Redirigir internamente al endpoint correspondiente
    // Se simula GET/POST/PUT/DELETE como si fuera directamente el archivo
    include_once $map[$resource];
} else {
    http_response_code(404);
    echo json_encode(["message" => "Recurso no encontrado"]);
}
