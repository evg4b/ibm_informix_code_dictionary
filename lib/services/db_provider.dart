import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE status_codes ("
                            "id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"
                            "code	TEXT NOT NULL,"
                            "short_description_rus	TEXT,"
                            "short_description_eng	TEXT,"
                            "description_rus	TEXT,"
                            "description_eng	TEXT"
                        ");");
        await db.execute("CREATE INDEX status_codes_code_index ON status_codes (code	ASC);");
    });
  }
}
