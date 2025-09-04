<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once __DIR__ . "/../config/database.php";
include_once __DIR__ . "/../models/Usuario.php";


$database = new Database();
$db = $database->getConnection();

$usuario = new Usuario($db);

$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        if (isset($_GET['id'])) {
            $stmt = $usuario->getById($_GET['id']);
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
            echo json_encode($row ?: ["message" => "Usuario no encontrado"]);
        } else {
            $stmt = $usuario->getAll();
            $usuarios = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($usuarios);
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"));
        if (!empty($data->username) && !empty($data->email) && !empty($data->password)) {
            if ($usuario->userExists($data->username, $data->email)) {
                http_response_code(409);
                echo json_encode(["message" => "El nombre de usuario o el email ya están registrados."]);
                break;
            }


            $usuario->username = $data->username;
            $usuario->email = $data->email;
            $usuario->password = $data->password;

            if ($usuario->create()) {
                http_response_code(201);
                echo json_encode(["message" => "Usuario creado con éxito."]);
            } else {
                http_response_code(503);
                echo json_encode(["message" => "Error al crear el usuario."]);
            }
        } else {
            http_response_code(400);
            echo json_encode(["message" => "Datos incompletos."]);
        }
        break;

    case 'PUT':
        $data = json_decode(file_get_contents("php://input"));
        if (isset($_GET['id']) && !empty($data->username) && !empty($data->email)) {
            $usuario->username = $data->username;
            $usuario->email = $data->email;

            if ($usuario->update($_GET['id'])) {
                echo json_encode(["message" => "Usuario actualizado"]);
            } else {
                echo json_encode(["message" => "Error al actualizar"]);
            }
        } else {
            echo json_encode(["message" => "Datos incompletos"]);
        }
        break;

    case 'DELETE':
        if (isset($_GET['id'])) {
            if ($usuario->delete($_GET['id'])) {
                echo json_encode(["message" => "Usuario eliminado"]);
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