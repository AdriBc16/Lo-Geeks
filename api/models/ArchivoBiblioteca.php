<?php
class ArchivoBiblioteca {
    private $conn;
    private $table = "ArchivoBiblioteca";

    public $id_archivo;
    public $nombre_archivo;
    public $fecha_subida;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Obtener todos
    public function getAll() {
        $query = "SELECT id_archivo, nombre_archivo, fecha_subida FROM " . $this->table;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    // Obtener uno
    public function getById($id) {
        $query = "SELECT id_archivo, nombre_archivo, fecha_subida FROM " . $this->table . " WHERE id_archivo = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id", $id);
        $stmt->execute();
        return $stmt;
    }

    // Crear
    public function create() {
        $query = "INSERT INTO " . $this->table . " (nombre_archivo) VALUES (:nombre_archivo)";
        $stmt = $this->conn->prepare($query);

        $this->nombre_archivo = htmlspecialchars(strip_tags($this->nombre_archivo));
        $stmt->bindParam(":nombre_archivo", $this->nombre_archivo);

        return $stmt->execute();
    }

    // Actualizar
    public function update($id) {
        $query = "UPDATE " . $this->table . " SET nombre_archivo = :nombre_archivo WHERE id_archivo = :id";
        $stmt = $this->conn->prepare($query);

        $this->nombre_archivo = htmlspecialchars(strip_tags($this->nombre_archivo));
        $stmt->bindParam(":nombre_archivo", $this->nombre_archivo);
        $stmt->bindParam(":id", $id);

        return $stmt->execute();
    }

    // Eliminar
    public function delete($id) {
        $query = "DELETE FROM " . $this->table . " WHERE id_archivo = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id", $id);
        return $stmt->execute();
    }
}
