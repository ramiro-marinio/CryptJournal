import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbProvider extends ChangeNotifier {
  Database? _database;

  Table? _diaryTable;
  Table get diaryTable {
    _diaryTable ??= Table(tableName: 'diary', db: database);
    return _diaryTable!;
  }

  Table? _entryTable;
  Table get entryTable {
    _entryTable ??= Table(tableName: 'entry', db: database);
    return _entryTable!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    String createTableQueries = await rootBundle.loadString('sql/setup.sql');
    List<String> queries = createTableQueries.split(';');
    for (String query in queries) {
      if (query.trim().isNotEmpty) {
        await db.execute(query);
      }
    }
  }
}

class Table {
  final String tableName;
  late Future<Database> db;
  Table({
    required this.tableName,
    required this.db,
  });
  Future<List<Map<String, dynamic>>> list(
      {String? where, String? orderBy, int? limit, int? offset}) async {
    final Database database = await db;
    final data = await database.query(
      tableName,
      where: where,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
    return data;
  }

  Future<bool> create({
    required Map<String, dynamic> object,
  }) async {
    (await db).insert(tableName, object);
    return true;
  }

  Future<bool> delete({
    String? where,
  }) async {
    (await db).delete(tableName, where: where);
    return true;
  }

  Future<bool> update({
    required Map<String, dynamic> object,
    String? where,
  }) async {
    (await db).update(tableName, object, where: where);
    return true;
  }
}
