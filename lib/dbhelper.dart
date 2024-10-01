import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/History.dart';
import 'model/ShoppingList.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();

  factory DbHelper() {
    return _instance;
  }

  DbHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'shopping_list.db');

    return await openDatabase(
      path,
      version: 2, // Ubah versi ke 2 jika tabel history ditambahkan
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE shopping_list(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          quantity INTEGER
        )
        ''');
        await db.execute('''
        CREATE TABLE history(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          quantity INTEGER,
          date TEXT
        )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
          CREATE TABLE history(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            quantity INTEGER,
            date TEXT
          )
          ''');
        }
      },
    );
  }

  Future<List<ShoppingList>> getShoppingLists() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('shopping_list');
    return List.generate(maps.length, (i) {
      return ShoppingList.fromMap(maps[i]);
    });
  }

  Future<List<History>> getHistory() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('history');
    return List.generate(maps.length, (i) {
      return History.fromMap(maps[i]);
    });
  }

  Future<void> insertShoppingList(ShoppingList shoppingList) async {
    final db = await database;
    await db.insert('shopping_list', shoppingList.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertHistory(History history) async {
    final db = await database;
    await db.insert('history', history.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteShoppingList(int id) async {
    final db = await database;
    await db.delete('shopping_list', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    final db = await database;
    await db.delete('shopping_list');
  }
}
