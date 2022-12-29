
import 'package:sqflite/sqflite.dart';




class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tblFavorite = 'favorite';
  final String _restaurantId = 'id';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/favorite.db',
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE $_tblFavorite ($_restaurantId TEXT PRIMARY KEY NOT NULL)');
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertFavorite(String restoId) async {
    final db = await database;
    await db!.rawInsert(
        'INSERT INTO $_tblFavorite($_restaurantId) VALUES ("$restoId")');
  }

  Future<List<String>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results.map((e) => e['id'] as String).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;

    await db.delete(
      _tblFavorite,
      where: '$_restaurantId = ?',
      whereArgs: [id],
    );
  }
}
