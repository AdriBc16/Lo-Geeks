<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: GET, POST, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once __DIR__ . "../config/database.php";
include_once __DIR__ . "../models/JuegoArchivo.php";

$database = new Database();
$db = $database->getConnection();

$juegoArchivo = new JuegoArchivo($db);

$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        if (isset($_GET['id_juego'])) {
            $stmt = $juegoArchivo->getByJuego($_GET['id_juego']);
            $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($data);
        } else {
            $stmt = $juegoArchivo->getAll();
            $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($data);
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"));
        if (!empty($data->id_juego) && !empty($data->id_archivo)) {
            $juegoArchivo->id_juego = $data->id_juego;
            $juegoArchivo->id_archivo = $data->id_archivo;

            if ($juegoArchivo->create()) {
                http_response_code(201);
                echo json_encode(["message" => "Relación juego-archivo creada"]);
            } else {
                http_response_code(503);
                echo json_encode(["message" => "Error al crear relación"]);
            }
        } else {
            http_response_code(400);
            echo json_encode(["message" => "Datos incompletos"]);
        }
        break;

    case 'DELETE':
        $data = json_decode(file_get_contents("php://input"));
        if (!empty($data->id_juego) && !empty($data->id_archivo)) {
            $juegoArchivo->id_juego = $data->id_juego;
            $juegoArchivo->id_archivo = $data->id_archivo;

            if ($juegoArchivo->delete()) {
                echo json_encode(["message" => "Relación eliminada"]);
            } else {
                echo json_encode(["message" => "Error al eliminar"]);
            }
        } else {
            echo json_encode(["message" => "Se requieren id_juego e id_archivo"]);
        }
        break;

    default:
        http_response_code(405);
        echo json_encode(["message" => "Método no permitido"]);
        break;
}
