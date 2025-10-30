
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
    $cat = intval($_GET['idCategoria'] ?? 0);
    $sql = "SELECT p.*, c.nombre as categoria FROM productos p LEFT JOIN categorias c ON p.idCategoria=c.idCategoria";
    if ($cat) $sql .= " WHERE p.idCategoria=$cat";
    $sql .= " ORDER BY p.idProductos DESC";
    $res = $conn->query($sql);
    $rows = [];
    while ($r = $res->fetch_assoc()) $rows[] = $r;
    echo json_encode($rows);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);
if ($method === 'POST') {
    $nombre = $conn->real_escape_string($input['nombre'] ?? $_POST['nombre'] ?? '');
    $descripcion = $conn->real_escape_string($input['descripcion'] ?? $_POST['descripcion'] ?? '');
    $precio = floatval($input['precio'] ?? $_POST['precio'] ?? 0);
    $idCategoria = intval($input['idCategoria'] ?? $_POST['idCategoria'] ?? 0);
    $sql = "INSERT INTO productos (nombre, descripcion, precio, idCategoria) VALUES ('$nombre', '$descripcion', $precio, $idCategoria)";
    if ($conn->query($sql)) echo json_encode(['success' => true]);
    else echo json_encode(['success' => false, 'error' => $conn->error]);
    exit;
}

if ($method === 'PUT') {
    $id = intval($_GET['idProductos'] ?? 0);
    $nombre = $conn->real_escape_string($input['nombre'] ?? '');
    $descripcion = $conn->real_escape_string($input['descripcion'] ?? '');
    $precio = floatval($input['precio'] ?? 0);
    $idCategoria = intval($input['idCategoria'] ?? 0);
    $sql = "UPDATE productos SET nombre='$nombre', descripcion='$descripcion', precio=$precio, idCategoria=$idCategoria WHERE idProductos=$id";
    if ($conn->query($sql)) echo json_encode(['success' => true]);
    else echo json_encode(['success' => false, 'error' => $conn->error]);
    exit;
}

if ($method === 'DELETE') {
    $id = intval($_GET['idProductos'] ?? 0);
    $sql = "DELETE FROM productos WHERE idProductos=$id";
    if ($conn->query($sql)) echo json_encode(['success' => true]);
    else echo json_encode(['success' => false, 'error' => $conn->error]);
    exit;
}
