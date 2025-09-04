<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");

include_once __DIR__ . '/../config/database.php';
include_once __DIR__ . '/../models/Puntaje.php';

$database = new Database();
$db = $database->getConnection();
$puntaje = new Puntaje($db);

$method = $_SERVER['REQUEST_METHOD'];

switch($method) {
    case 'GET':
        if (isset($_GET['id_puntaje'])) {
            $puntaje->id_puntaje = $_GET['id_puntaje'];
            $data = $puntaje->readOne();
            echo json_encode($data ? $data : ["message" => "No encontrado"]);
        } else {
            $stmt = $puntaje->readAll();
            $puntajes = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($puntajes);
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"));
        if (!empty($data->id_partida) && !empty($data->puntaje) && !empty($data->tiempo_jugado)) {
            $puntaje->id_partida = $data->id_partida;
            $puntaje->puntaje = $data->puntaje;
            $puntaje->tiempo_jugado = $data->tiempo_jugado;

            echo $puntaje->create()
                ? json_encode(["message" => "Puntaje creado"])
                : json_encode(["message" => "Error al crear"]);
        } else {
            echo json_encode(["message" => "Datos incompletos"]);
        }
        break;

    case 'PUT':
        $data = json_decode(file_get_contents("php://input"));
        if (!empty($data->id_puntaje)) {
            $puntaje->id_puntaje = $data->id_puntaje;
            $puntaje->id_partida = $data->id_partida;
            $puntaje->puntaje = $data->puntaje;
            $puntaje->tiempo_jugado = $data->tiempo_jugado;

            echo $puntaje->update()
                ? json_encode(["message" => "Puntaje actualizado"])
                : json_encode(["message" => "Error al actualizar"]);
        } else {
            echo json_encode(["message" => "ID requerido"]);
        }
        break;

    case 'DELETE':
        if (isset($_GET['id_puntaje'])) {
            $puntaje->id_puntaje = $_GET['id_puntaje'];
            echo $puntaje->delete()
                ? json_encode(["message" => "Puntaje eliminado"])
                : json_encode(["message" => "Error al eliminar"]);
        } else {
            echo json_encode(["message" => "ID requerido"]);
        }
        break;

    default:
        echo json_encode(["message" => "Método no permitido"]);
}
