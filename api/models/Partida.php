<?php
class Partida {
    private $conn;
    private $table = "Partida";

    public $id_partida;
    public $id_usuario;
    public $id_juego;
    public $fecha_inicio;
    public $fecha_fin;
    public $estado;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Crear partida
    public function create() {
        $query = "INSERT INTO " . $this->table . " 
                  (id_usuario, id_juego, fecha_inicio, fecha_fin, estado) 
                  VALUES (:id_usuario, :id_juego, :fecha_inicio, :fecha_fin, :estado)";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":id_usuario", $this->id_usuario);
        $stmt->bindParam(":id_juego", $this->id_juego);
        $stmt->bindParam(":fecha_inicio", $this->fecha_inicio);
        $stmt->bindParam(":fecha_fin", $this->fecha_fin);
        $stmt->bindParam(":estado", $this->estado);

        return $stmt->execute();
    }

    // Obtener todas las partidas
    public function readAll() {
        $query = "SELECT * FROM " . $this->table;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    // Obtener partida por ID
    public function readOne() {
        $query = "SELECT * FROM " . $this->table . " WHERE id_partida = ? LIMIT 0,1";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(1, $this->id_partida);
        $stmt->execute();

        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($row) {
            $this->id_usuario = $row['id_usuario'];
            $this->id_juego = $row['id_juego'];
            $this->fecha_inicio = $row['fecha_inicio'];
            $this->fecha_fin = $row['fecha_fin'];
            $this->estado = $row['estado'];
        }
    }

    // Actualizar partida
    public function update() {
        $query = "UPDATE " . $this->table . " 
                  SET id_usuario=:id_usuario, id_juego=:id_juego, 
                      fecha_inicio=:fecha_inicio, fecha_fin=:fecha_fin, estado=:estado
                  WHERE id_partida=:id_partida";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":id_usuario", $this->id_usuario);
        $stmt->bindParam(":id_juego", $this->id_juego);
        $stmt->bindParam(":fecha_inicio", $this->fecha_inicio);
        $stmt->bindParam(":fecha_fin", $this->fecha_fin);
        $stmt->bindParam(":estado", $this->estado);
        $stmt->bindParam(":id_partida", $this->id_partida);

        return $stmt->execute();
    }

    // Eliminar partida
    public function delete() {
        $query = "DELETE FROM " . $this->table . " WHERE id_partida = :id_partida";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id_partida", $this->id_partida);
        return $stmt->execute();
    }
}
