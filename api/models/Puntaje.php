<?php
class Puntaje {
    private $conn;
    private $table = "Puntaje";

    public $id_puntaje;
    public $id_partida;
    public $puntaje;
    public $tiempo_jugado;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Crear
    public function create() {
        $query = "INSERT INTO " . $this->table . " (id_partida, puntaje, tiempo_jugado) 
                  VALUES (:id_partida, :puntaje, :tiempo_jugado)";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":id_partida", $this->id_partida);
        $stmt->bindParam(":puntaje", $this->puntaje);
        $stmt->bindParam(":tiempo_jugado", $this->tiempo_jugado);

        return $stmt->execute();
    }

    // Leer todo
    public function readAll() {
        $query = "SELECT * FROM " . $this->table;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    // Leer uno
    public function readOne() {
        $query = "SELECT * FROM " . $this->table . " WHERE id_puntaje = :id_puntaje LIMIT 0,1";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id_puntaje", $this->id_puntaje);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Actualizar
    public function update() {
        $query = "UPDATE " . $this->table . " 
                  SET id_partida = :id_partida, puntaje = :puntaje, tiempo_jugado = :tiempo_jugado 
                  WHERE id_puntaje = :id_puntaje";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":id_partida", $this->id_partida);
        $stmt->bindParam(":puntaje", $this->puntaje);
        $stmt->bindParam(":tiempo_jugado", $this->tiempo_jugado);
        $stmt->bindParam(":id_puntaje", $this->id_puntaje);

        return $stmt->execute();
    }

    // Eliminar
    public function delete() {
        $query = "DELETE FROM " . $this->table . " WHERE id_puntaje = :id_puntaje";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id_puntaje", $this->id_puntaje);
        return $stmt->execute();
    }
}
