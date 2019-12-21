import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:ibm_informix_code_dictionary/models/status_code.dart';
import 'package:ibm_informix_code_dictionary/models/status_code_list_item.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final DBProvider db = DBProvider._();
  static Database _database;

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "asset_database.db");
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load(join('assets', 'database.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await new File(path).writeAsBytes(bytes);
    }
    return await openDatabase(path, version: 1);
  }

  Future<StatusCode> getCode(int id) async {
    final db = await database;
    var res = await db.query("status_codes", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? StatusCode.fromMap(res.first) : Null;
  }

  Future<List<StatusCodeListItem>> getList(String query, int skip) async {
    print("List by $query");
    final db = await database;
    var res = await db.rawQuery(
        "SELECT id, code, short_description FROM status_codes WHERE code LIKE '%$query%' ORDER BY code LIMIT $skip, 20");
    var d = res.map((p) => StatusCodeListItem.fromMap(p));
    return res.isNotEmpty ? d.toList() : List<StatusCodeListItem>();
  }

  Future<int> count(String query) async {
    print("Count by $query");
    final db = await database;
    var res = await db.rawQuery(
        "SELECT COUNT(*) AS count FROM status_codes WHERE code LIKE '%$query%'");
    int count = res.first["count"];
    return count;
  }
}
