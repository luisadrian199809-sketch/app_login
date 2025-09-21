
<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
header('Content-Type: application/json; charset=utf-8');
include 'config.php';
?>


$method = $_SERVER['REQUEST_METHOD'];
if ($method === 'OPTIONS') { echo json_encode(['ok'=>true]); exit; }

if ($method === 'GET') {
    $res = $conn->query("SELECT * FROM categorias ORDER BY idCategoria DESC");
    $rows = [];
    while ($r = $res->fetch_assoc()) $rows[] = $r;
    echo json_encode($rows);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);
if ($method === 'POST') {
    $nombre = $conn->real_escape_string($input['nombre'] ?? $_POST['nombre'] ?? '');
    $descripcion = $conn->real_escape_string($input['descripcion'] ?? $_POST['descripcion'] ?? '');
    $sql = "INSERT INTO categorias (nombre, descripcion) VALUES ('$nombre', '$descripcion')";
    if ($conn->query($sql)) echo json_encode(['success' => true]);
    else echo json_encode(['success' => false, 'error' => $conn->error]);
    exit;
}

if ($method === 'PUT') {
    $id = intval($_GET['idCategoria'] ?? 0);
    $nombre = $conn->real_escape_string($input['nombre'] ?? '');
    $descripcion = $conn->real_escape_string($input['descripcion'] ?? '');
    $sql = "UPDATE categorias SET nombre='$nombre', descripcion='$descripcion' WHERE idCategoria=$id";
    if ($conn->query($sql)) echo json_encode(['success' => true]);
    else echo json_encode(['success' => false, 'error' => $conn->error]);
    exit;
}

if ($method === 'DELETE') {
    $id = intval($_GET['idCategoria'] ?? 0);
    $sql = "DELETE FROM categorias WHERE idCategoria=$id";
    if ($conn->query($sql)) echo json_encode(['success' => true]);
    else echo json_encode(['success' => false, 'error' => $conn->error]);
    exit;
}
