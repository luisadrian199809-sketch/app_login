
<?php
// config.php - DB connection
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "tienda_app";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}
?>
