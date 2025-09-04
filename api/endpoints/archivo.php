<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once __DIR__ . "/../config/database.php";
include_once __DIR__ . "/../models/ArchivoBiblioteca.php";

$database = new Database();
$db = $database->getConnection();

$archivo = new ArchivoBiblioteca($db);

$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        if (isset($_GET['id'])) {
            $stmt = $archivo->getById($_GET['id']);
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
            echo json_encode($row ?: ["message" => "Archivo no encontrado"]);
        } else {
            $stmt = $archivo->getAll();
            $archivos = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($archivos);
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"));
        if (!empty($data->nombre_archivo)) {
            $archivo->nombre_archivo = $data->nombre_archivo;

            if ($archivo->create()) {
                http_response_code(201);
                echo json_encode(["message" => "Archivo creado con éxito"]);
            } else {
                http_response_code(503);
                echo json_encode(["message" => "Error al crear archivo"]);
            }
        } else {
            http_response_code(400);
            echo json_encode(["message" => "Datos incompletos"]);
        }
        break;

    case 'PUT':
        $data = json_decode(file_get_contents("php://input"));
        if (isset($_GET['id']) && !empty($data->nombre_archivo)) {
            $archivo->nombre_archivo = $data->nombre_archivo;

            if ($archivo->update($_GET['id'])) {
                echo json_encode(["message" => "Archivo actualizado"]);
            } else {
                echo json_encode(["message" => "Error al actualizar"]);
            }
        } else {
            echo json_encode(["message" => "Datos incompletos"]);
        }
        break;

    case 'DELETE':
        if (isset($_GET['id'])) {
            if ($archivo->delete($_GET['id'])) {
                echo json_encode(["message" => "Archivo eliminado"]);
            } else {
                echo json_encode(["message" => "Error al eliminar"]);
            }
        } else {
            echo json_encode(["message" => "ID requerido"]);
        }
        break;

    default:
        http_response_code(405);
        echo json_encode(["message" => "Método no permitido"]);
        break;
}
