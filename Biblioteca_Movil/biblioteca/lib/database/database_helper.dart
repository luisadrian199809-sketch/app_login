import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';
import '../models/book.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('biblioteca.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE purchased_books(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        author TEXT NOT NULL,
        price REAL NOT NULL,
        image TEXT NOT NULL,
        description TEXT,
        url TEXT NOT NULL
      )
    ''');
  }

  // Insertar usuario
  Future<void> insertUser(User user) async {
    final Database db = await instance.database;
    await db.insert('users', user.toMap());
  }

  // Obtener usuario para login
  Future<User?> getUser(String email, String password) async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return User(
        username: maps.first['username'] as String,
        email: maps.first['email'] as String,
        password: maps.first['password'] as String,
      );
    } else {
      return null;
    }
  }

  // Insertar libro comprado
  Future<void> insertPurchasedBook(Book book) async {
    final Database db = await instance.database;
    await db.insert('purchased_books', {
      'title': book.title,
      'author': book.author,
      'price': book.price,
      'image': book.image,
      'description': book.description,
      'url': book.url,
    });
  }

  // Obtener libros comprados
  Future<List<Book>> getPurchasedBooks() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('purchased_books');

    return List.generate(maps.length, (i) {
      return Book(
        title: maps[i]['title'] as String,
        author: maps[i]['author'] as String,
        price: maps[i]['price'] is int
            ? (maps[i]['price'] as int).toDouble()
            : maps[i]['price'] as double,
        image: maps[i]['image'] as String,
        description: maps[i]['description'] as String? ?? '',
        url: maps[i]['url'] as String,
      );
    });
  }
}
