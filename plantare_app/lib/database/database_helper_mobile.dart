import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperImplementation {
  static final _databaseName = "usuarios.db";
  static final _databaseVersion = 1;
  static final table = 'Usuario';
  static final columnId = 'UsuarioID';
  static final columnName = 'Nome';
  static final columnEmail = 'Email';
  static final columnSenha = 'Senha';

  DatabaseHelperImplementation._privateConstructor();
  static final DatabaseHelperImplementation instance = DatabaseHelperImplementation._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnEmail TEXT NOT NULL,
        $columnSenha TEXT NOT NULL
      )
    ''');
    await insertInitialUsers(db);
  }

  Future<void> insertInitialUsers(Database db) async {
    List<Map<String, dynamic>> initialUsers = [
      {'Nome': 'Abner', 'Email': 'abner@gmail.com', 'Senha': '!Abner!@'},
      // Adicione mais usuários conforme necessário
    ];
    Batch batch = db.batch();
    for (var user in initialUsers) {
      batch.insert(table, user);
    }
    await batch.commit(noResult: true);
  }

  Future<Map<String, dynamic>?> login(String email, String senha) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      table,
      where: '$columnEmail = ? AND $columnSenha = ?',
      whereArgs: [email, senha],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future close() async {
    Database db = await instance.database;
    db.close();
  }
}