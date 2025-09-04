<?php
header("Content-Type: application/json; charset=UTF-8");

include_once __DIR__ . "/../config/database.php";
include_once __DIR__ . "/../models/Partida.php";

$database = new Database();
$db = $database->getConnection();

$partida = new Partida($db);

$method = $_SERVER['REQUEST_METHOD'];

switch($method) {
    case 'GET':
        if (isset($_GET['id'])) {
            $partida->id_partida = $_GET['id'];
            $partida->readOne();
            echo json_encode($partida);
        } else {
            $stmt = $partida->readAll();
            $partidas = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($partidas);
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"));
        if (!empty($data->id_usuario) && !empty($data->id_juego)) {
            $partida->id_usuario = $data->id_usuario;
            $partida->id_juego = $data->id_juego;
            $partida->fecha_inicio = $data->fecha_inicio ?? date("Y-m-d H:i:s");
            $partida->fecha_fin = $data->fecha_fin ?? null;
            $partida->estado = $data->estado ?? "en curso";

            if ($partida->create()) {
                echo json_encode(["message" => "Partida creada"]);
            } else {
                echo json_encode(["message" => "Error al crear partida"]);
            }
        } else {
            echo json_encode(["message" => "Datos incompletos"]);
        }
        break;

    case 'PUT':
        $data = json_decode(file_get_contents("php://input"));
        if (!empty($data->id_partida)) {
            $partida->id_partida = $data->id_partida;
            $partida->id_usuario = $data->id_usuario;
            $partida->id_juego = $data->id_juego;
            $partida->fecha_inicio = $data->fecha_inicio;
            $partida->fecha_fin = $data->fecha_fin;
            $partida->estado = $data->estado;

            if ($partida->update()) {
                echo json_encode(["message" => "Partida actualizada"]);
            } else {
                echo json_encode(["message" => "Error al actualizar partida"]);
            }
        } else {
            echo json_encode(["message" => "ID de partida requerido"]);
        }
        break;

    case 'DELETE':
        if (isset($_GET['id'])) {
            $partida->id_partida = $_GET['id'];
            if ($partida->delete()) {
                echo json_encode(["message" => "Partida eliminada"]);
            } else {
                echo json_encode(["message" => "Error al eliminar partida"]);
            }
        } else {
            echo json_encode(["message" => "ID de partida requerido"]);
        }
        break;
}
