import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/password_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'password_manager.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE passwords (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        websiteName TEXT NOT NULL,
        websiteLogoUrl TEXT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        websiteAddress TEXT,
        notes TEXT,
        category TEXT,
        connectedAccount TEXT
      )
    ''');
  }

  Future<int> insertPassword(Password password) async {
    final db = await database;
    return await db.insert('passwords', password.toMap());
  }

  Future<List<Password>> getAllPasswords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('passwords');
    return List.generate(maps.length, (i) => Password.fromMap(maps[i]));
  }

  Future<int> updatePassword(Password password) async {
    final db = await database;
    return await db.update(
      'passwords',
      password.toMap(),
      where: 'id = ?',
      whereArgs: [password.id],
    );
  }

  Future<int> deletePassword(int id) async {
    final db = await database;
    return await db.delete(
      'passwords',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Password?> getPasswordById(int id) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'passwords',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Password.fromMap(maps.first);
    }
    return null; // Return null if no password is found
  }

}