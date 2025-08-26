<?php
class Juego {
    private $conn;
    private $table = "Juego";

    public $id_juego;
    public $titulo;
    public $descripcion;
    public $estado;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Obtener todos
    public function getAll() {
        $query = "SELECT id_juego, titulo, descripcion, estado FROM " . $this->table;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    // Obtener uno
    public function getById($id) {
        $query = "SELECT id_juego, titulo, descripcion, estado FROM " . $this->table . " WHERE id_juego = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id", $id);
        $stmt->execute();
        return $stmt;
    }

    // Crear
    public function create() {
        $query = "INSERT INTO " . $this->table . " (titulo, descripcion, estado) 
                  VALUES (:titulo, :descripcion, :estado)";
        $stmt = $this->conn->prepare($query);

        $this->titulo = htmlspecialchars(strip_tags($this->titulo));
        $this->descripcion = htmlspecialchars(strip_tags($this->descripcion));
        $this->estado = htmlspecialchars(strip_tags($this->estado));

        $stmt->bindParam(":titulo", $this->titulo);
        $stmt->bindParam(":descripcion", $this->descripcion);
        $stmt->bindParam(":estado", $this->estado);

        return $stmt->execute();
    }

    // Actualizar
    public function update($id) {
        $query = "UPDATE " . $this->table . " 
                  SET titulo = :titulo, descripcion = :descripcion, estado = :estado 
                  WHERE id_juego = :id";
        $stmt = $this->conn->prepare($query);

        $this->titulo = htmlspecialchars(strip_tags($this->titulo));
        $this->descripcion = htmlspecialchars(strip_tags($this->descripcion));
        $this->estado = htmlspecialchars(strip_tags($this->estado));

        $stmt->bindParam(":titulo", $this->titulo);
        $stmt->bindParam(":descripcion", $this->descripcion);
        $stmt->bindParam(":estado", $this->estado);
        $stmt->bindParam(":id", $id);

        return $stmt->execute();
    }

    // Eliminar
    public function delete($id) {
        $query = "DELETE FROM " . $this->table . " WHERE id_juego = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id", $id);
        return $stmt->execute();
    }
}
