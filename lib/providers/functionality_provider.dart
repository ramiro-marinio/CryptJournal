import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;

class FunctionalityProvider extends ChangeNotifier {
  Uint8List? password;
  final iv = encrypt.IV.fromBase64("fuckthisshit");
  late Future<bool> _initialized;
  bool initialized = false;
  late final String databasePath;
  final databaseName = 'database.db';
  final encryptedDatabaseName = '/database.aes';
  late final String encryptedDirPath;

  /// 0 = Database never created.
  /// 1 = Database created. Not authenticated.
  /// 2 = Database created. Authenticated.
  int authStatus = 0;
  void changeAuthStatus(int newVal) {
    authStatus = newVal;
    notifyListeners();
  }

  Future<bool> _init() async {
    databasePath = await getDatabasesPath();
    encryptedDirPath = '$databasePath/encrypted';
    await Directory(encryptedDirPath).create();
    authStatus = (await checkDatabaseExists()) ? 1 : 0;
    initialized = true;
    notifyListeners();
    return true;
  }

  FunctionalityProvider() {
    _initialized = _init();
  }

  Database? _database;

  Table? _diaryTable;
  Table get diaryTable {
    _diaryTable ??= Table(
      tableName: 'diary',
      db: database,
      notifyListeners: notifyListeners,
    );
    return _diaryTable!;
  }

  Table? _entryTable;
  Table get entryTable {
    _entryTable ??= Table(
      tableName: 'entry',
      db: database,
      notifyListeners: notifyListeners,
    );
    return _entryTable!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database?> _initDB() async {
    await _initialized;
    String path = join(databasePath, databaseName);
    final encryptedDatabaseFilePath =
        '$encryptedDirPath/$encryptedDatabaseName';
    final encryptedDatabaseFile = File(encryptedDatabaseFilePath);

    if (!(await encryptedDatabaseFile.exists())) {
      return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreateDatabase,
      );
    }
    return null;
  }

  Future<bool> checkDatabaseExists() async {
    return (await File('$encryptedDirPath/$encryptedDatabaseName').exists()) ||
        (await File('$databasePath/$databaseName').exists());
  }

  Future<void> _onCreateDatabase(Database db, int version) async {
    String createTableQueries = await rootBundle.loadString('sql/setup.sql');
    List<String> queries = createTableQueries.split(';');
    for (String query in queries) {
      if (query.trim().isNotEmpty) {
        await db.execute(query);
      }
    }
  }

  Future<bool> encryptDatabase() async {
    final encrypter = encrypt.Encrypter(
      encrypt.AES(
        encrypt.Key(password!),
      ),
    );
    final databaseBytes =
        (await File('$databasePath/$databaseName').readAsBytes()).toList();
    final encryptedResult =
        encrypter.encryptBytes(databaseBytes, iv: iv).bytes.toList();
    await File(
      '$encryptedDirPath/$encryptedDatabaseName',
    ).writeAsBytes(encryptedResult);
    await deleteDatabase('$databasePath/$databaseName');
    return true;
  }

  Future<bool> decryptDatabase() async {
    final encryptedDatabaseFile = File(
      '$encryptedDirPath/$encryptedDatabaseName',
    );
    final bytes = (await encryptedDatabaseFile.readAsBytes());

    final encrypter = encrypt.Encrypter(
      encrypt.AES(
        encrypt.Key(password!),
      ),
    );
    final decryptedDatabase = encrypter.decryptBytes(
      encrypt.Encrypted(bytes),
      iv: iv,
    );
    await encryptedDatabaseFile.delete();
    await File('$databasePath/$databaseName').writeAsBytes(decryptedDatabase);
    return true;
  }
}

class Table {
  final String tableName;
  late Future<Database> db;
  final VoidCallback notifyListeners;
  Table(
      {required this.tableName,
      required this.db,
      required this.notifyListeners});
  Future<List<Map<String, dynamic>>> list(
      {String? where, String? orderBy, int? limit, int? offset}) async {
    final Database database = await db;
    final data = await database.query(
      tableName,
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
    );
    return data;
  }

  Future<bool> create({
    required Map<String, dynamic> object,
  }) async {
    notifyListeners();
    return true;
  }

  Future<bool> delete({
    String? where,
  }) async {
    (await db).delete(tableName, where: where);
    notifyListeners();
    return true;
  }

  Future<bool> update({
    required Map<String, dynamic> object,
    String? where,
  }) async {
    (await db).update(tableName, object, where: where);
    notifyListeners();
    return true;
  }
}
