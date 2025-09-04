<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once __DIR__ . "/../config/database.php";
include_once __DIR__ . "/../models/Juego.php";

$database = new Database();
$db = $database->getConnection();

$juego = new Juego($db);

$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        if (isset($_GET['id'])) {
            $stmt = $juego->getById($_GET['id']);
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
            echo json_encode($row ?: ["message" => "Juego no encontrado"]);
        } else {
            $stmt = $juego->getAll();
            $juegos = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($juegos);
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"));
        if (!empty($data->titulo) && isset($data->estado)) {
            $juego->titulo = $data->titulo;
            $juego->descripcion = $data->descripcion ?? "";
            $juego->estado = in_array($data->estado, ["borrador","publicado","archivado"])
                ? $data->estado
                : "borrador";

            if ($juego->create()) {
                http_response_code(201);
                echo json_encode(["message" => "Juego creado con éxito"]);
            } else {
                http_response_code(503);
                echo json_encode(["message" => "Error al crear juego"]);
            }
        } else {
            http_response_code(400);
            echo json_encode(["message" => "Datos incompletos"]);
        }
        break;

    case 'PUT':
        $data = json_decode(file_get_contents("php://input"));
        if (isset($_GET['id']) && !empty($data->titulo) && isset($data->estado)) {
            $juego->titulo = $data->titulo;
            $juego->descripcion = $data->descripcion ?? "";
            $juego->estado = in_array($data->estado, ["borrador","publicado","archivado"])
                ? $data->estado
                : "borrador";

            if ($juego->update($_GET['id'])) {
                echo json_encode(["message" => "Juego actualizado"]);
            } else {
                echo json_encode(["message" => "Error al actualizar"]);
            }
        } else {
            echo json_encode(["message" => "Datos incompletos"]);
        }
        break;

    case 'DELETE':
        if (isset($_GET['id'])) {
            if ($juego->delete($_GET['id'])) {
                echo json_encode(["message" => "Juego eliminado"]);
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
