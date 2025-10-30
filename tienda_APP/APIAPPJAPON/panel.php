
<?php
session_start();
include 'config.php';

function h($s){ return htmlspecialchars($s); }

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['login'])) {
    $email = $conn->real_escape_string($_POST['email']);
    $password = $conn->real_escape_string($_POST['password']);
    $sql = "SELECT * FROM usuarios WHERE email='$email' AND password='$password'";
    $res = $conn->query($sql);
    if ($row = $res->fetch_assoc()) {
        $_SESSION['user'] = $row;
        header('Location: panel.php');
        exit;
    } else {
        $error = 'Login incorrecto';
    }
}

if (isset($_SESSION['user']) && $_SESSION['user']) {
    $user = $_SESSION['user'];
} else {
    $user = null;
}

if (!$user) {
    ?>
    <h2>Login</h2>
    <?php if (!empty($error)) echo '<p style="color:red;">'.h($error).'</p>'; ?>
    <form method="post">
      Email: <input name="email" /><br>
      Password: <input name="password" type="password" /><br>
      <button name="login">Entrar</button>
    </form>
    <?php
    exit;
}

// Logout
if (isset($_GET['logout'])) {
    session_destroy();
    header('Location: panel.php');
    exit;
}

if ($user['idRol'] == 1) { // admin
    if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['addProduct'])) {
        $nombre = $conn->real_escape_string($_POST['nombre']);
        $descripcion = $conn->real_escape_string($_POST['descripcion']);
        $precio = floatval($_POST['precio']);
        $cat = intval($_POST['idCategoria']);
        $conn->query("INSERT INTO productos (nombre, descripcion, precio, idCategoria) VALUES ('$nombre','$descripcion',$precio,$cat)") or die($conn->error);
        echo '<p style="color:green;">Producto agregado</p>';
    }
    echo '<h1>Panel Admin</h1>';
    echo '<p>Bienvenido, '.h($user['nombre']).' | <a href="?logout=1">Cerrar sesión</a></p>';
    echo '<h3>Agregar producto</h3>';
    $cats = $conn->query('SELECT * FROM categorias');
    ?>
    <form method="post">
      Nombre: <input name="nombre"><br>
      Descripción: <input name="descripcion"><br>
      Precio: <input name="precio"><br>
      Categoría: <select name="idCategoria">
        <?php while($c = $cats->fetch_assoc()){ echo '<option value="'.h($c['idCategoria']).'">'.h($c['nombre']).'</option>'; } ?>
      </select><br>
      <button name="addProduct">Agregar producto</button>
    </form>
    <h3>Productos existentes</h3>
    <?php
    $prods = $conn->query('SELECT p.*, c.nombre as categoria FROM productos p LEFT JOIN categorias c ON p.idCategoria=c.idCategoria');
    echo '<ul>';
    while ($p = $prods->fetch_assoc()) {
        echo '<li>'.h($p['nombre']).' - '.h($p['categoria']).' - $'.h($p['precio']).'</li>';
    }
    echo '</ul>';
} else {
    echo '<h1>Panel Cliente</h1>';
    echo '<p>Bienvenido, '.h($user['nombre']).' | <a href="?logout=1">Cerrar sesión</a></p>';
    $prods = $conn->query('SELECT p.*, c.nombre as categoria FROM productos p LEFT JOIN categorias c ON p.idCategoria=c.idCategoria');
    echo '<ul>';
    while ($p = $prods->fetch_assoc()) {
        echo '<li>'.h($p['nombre']).' - '.h($p['categoria']).' - $'.h($p['precio']).'</li>';
    }
    echo '</ul>';
}
