import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/transaction.dart' as txn;

// database table and column names
const String tableTransactions = 'transactions';
const String columnId = 'id';
const String columnTitle = 'title';
const String columnAmount = 'amount';
const String columnDate = 'date';

// singleton class to manage the database
class DatabaseHelper {
  // Make this a singleton class.
  DatabaseHelper._init();

  static final DatabaseHelper instance = DatabaseHelper._init();

  // Only allow a single open connection to the database.
  static Database? _database;

  // actual database filename that is saved in the docs directory.
  static const _databaseName = "transactionsDB.db";

  // Increment this version when you need to change the schema.
  static const _databaseVersion = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  // Database helper methods:

  Future<int> insert(txn.Transaction element) async {
    final db = await instance.database;
    final id = await db.insert(tableTransactions, element.toMap());
    return id;
  }

  Future<txn.Transaction?> getTransactionById(int id) async {
    final db = await instance.database;
    List<Map> res = await db.query(tableTransactions,
        columns: [columnId, columnTitle, columnAmount, columnDate],
        where: '$columnId = ?',
        whereArgs: [id]);

    if (res.isNotEmpty) {
      return txn.Transaction.fromMap(res.first as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<txn.Transaction>> getAllTransactions() async {
    final db = await instance.database;
    List<Map> res = await db.query(tableTransactions,
        columns: [columnId, columnTitle, columnAmount, columnDate]);

    List<txn.Transaction> list = res
        .map((e) => txn.Transaction.fromMap(e as Map<String, dynamic>))
        .toList();

    return list;
  }

  Future<int> deleteTransactionById(int? id) async {
    final db = await instance.database;
    int res =
        await db.delete(tableTransactions, where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllTransactions() async {
    final db = await instance.database;
    int res = await db.delete(tableTransactions, where: '1');
    return res;
  }

  // open the database
  Future<Database> _initDB() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    print("Expense Database --> " + documentsDirectory.path);
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableTransactions (
            $columnId INTEGER PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnAmount REAL NOT NULL,
            $columnDate TEXT NOT NULL
          )
          ''');
  }
}
