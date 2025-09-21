<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
header('Content-Type: application/json; charset=utf-8');

include 'config.php';

$input = json_decode(file_get_contents('php://input'), true);
$email = isset($input['email']) ? trim($input['email']) : '';
$password = isset($input['password']) ? $input['password'] : '';

if (!$email || !$password) {
    echo json_encode(['success' => false, 'message' => 'Email y password son requeridos']);
    exit;
}

// Prepared statement: comparar password con SHA2 en la consulta
$stmt = $conn->prepare("SELECT u.idUsuario, u.nombre, u.email, u.idRol, IFNULL(r.nombre,'user') as rol
                        FROM usuarios u
                        LEFT JOIN roles r ON u.idRol = r.idRol
                        WHERE u.email = ? AND u.password = SHA2(?,256) LIMIT 1");
if (!$stmt) {
    echo json_encode(['success' => false, 'message' => 'Error en preparación de consulta']);
    exit;
}
$stmt->bind_param('ss', $email, $password);
$stmt->execute();
$result = $stmt->get_result();
if ($row = $result->fetch_assoc()) {
    echo json_encode(['success' => true, 'user' => $row]);
} else {
    echo json_encode(['success' => false, 'message' => 'Credenciales incorrectas']);
}
$stmt->close();
$conn->close();
?>