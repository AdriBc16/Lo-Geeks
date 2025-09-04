<?php
class Database {
    private $host = "localhost";
    private $db_name = "geek";
    private $username = "root";
    private $password = "H&Dz123";

    public $conn;

    public function getConnection() {
        $this->conn = null;
        try {
            $this->conn = new PDO(
                "mysql:host=" . $this->host . ";dbname=" . $this->db_name,
                $this->username,
                $this->password
            );
            $this->conn->exec("set names utf8");
        } catch(PDOException $exception) {
            http_response_code(503);
            die(json_encode([
                "status" => "error",
                "message" => "Error de conexión a la base de datos.",
                "details" => $exception->getMessage()
            ]));
        }
        return $this->conn;
    }
}