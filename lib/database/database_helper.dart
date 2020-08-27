import 'package:flutter_healthy_fitness/model/category_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database _database;
  static final DatabaseHelper instance = DatabaseHelper._instance();
  DatabaseHelper._instance();

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  _initDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path + 'healthyfitness.db');
    final healthyFitnessDB =
        await openDatabase(path, version: 1,onOpen: (database){}, onCreate: _createDB);
    return healthyFitnessDB;
  }

  String categoryTable = 'category_table';
  String categoryId = 'category_id';
  String categoryName = 'category_name';
  String categoryImage = 'category_image';

  void _createDB(Database db, int version) async {
    await db.execute('''CREATE TABLE category_table(
        $categoryId INTEGER,
        $categoryName TEXT,
        $categoryImage TEXT
      )''');
  }

  createFood(Categories categories) async {
    await deleteAllCategories();
    Database db = await this.database;
    final res = await db.insert(
      'category_table', 
    categories.toJson(),
    conflictAlgorithm: ConflictAlgorithm.replace);
    print("createcateresult>>>"+res.toString());
    return res;
  }

  Future<int> deleteAllCategories() async {
    Database db = await this.database;
    final res = await db.rawDelete('DELETE FROM category_table');
    return res;
  }

  Future<List<Categories>> getAllCategoriesfromDb() async {
    Database db = await database;
    final res = await db.rawQuery('SELECT * FROM category_table');
    print("res>>>"+res.length.toString());
    List<Categories> list = res.isNotEmpty ? res.map((e) => Categories.fromJson(e)).toList() : [];
    print("getallcatelist>>>$list");
    return list;
  }
}
