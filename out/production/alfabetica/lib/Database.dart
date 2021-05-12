import 'dart:async';
import 'dart:io';

import 'package:Alfabetica/model/ItemFase.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    //initDatabase inidb = new initDatabase();
    //await inidb.drop();
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();

    //if (_database == null)


    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Fase ("
              "id INTEGER PRIMARY KEY,"
              "local String,"
              "name STRING,"
              "numeroFase INTEGER,"
              "url STRING,"
              "lock BIT"
              ")");
        });
  }

  newFase(ItemFase newFase) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Fase");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Fase (id, local, name,numeroFase,url,lock)"
            " VALUES (?,?,?,?,?,?)",
        [id, newFase.local, newFase.name,  newFase.numeroFase, newFase.url, newFase.lock]);
    return raw;
  }

  blockOrUnblock(ItemFase fase) async {
    final db = await database;
    ItemFase locked = ItemFase(
        id: fase.id,
        name: fase.name,
        numeroFase: fase.numeroFase,
        url: fase.url,
        lock: !fase.lock);
    var res = await db.update("Fase", locked.toMap(),
        where: "id = ?", whereArgs: [locked.id]);
    return res;
  }

  updateFase(ItemFase newFase) async {
    final db = await database;
    var res = await db.update("Fase", newFase.toMap(),
        where: "id = ?", whereArgs: [newFase.id]);
    return res;
  }

  Future<ItemFase> getFase(int id) async {
    final db = await database;
    var res = await db.query("Fase", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? ItemFase.fromMap(res.first) : null;
  }

  Future<List<ItemFase>> getlockedFases() async {
    final db = await database;
    // var res = await db.rawQuery("SELECT * FROM Fase WHERE lock=1");
    var res = await db.query("Fase", where: "lock = ? ", whereArgs: [1]);

    List<ItemFase> list =
    res.isNotEmpty ? res.map((c) => ItemFase.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<ItemFase>> getFasesByLocal(String local) async {
    final db = await database;
    var res = await db.query("Fase", where: "local = ?", whereArgs: [local]);
    List<ItemFase> list =
    res.isNotEmpty ? res.map((c) => ItemFase.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<ItemFase>> getAllFases() async {
    final db = await database;
    var res = await db.query("Fase");
    List<ItemFase> list =
    res.isNotEmpty ? res.map((c) => ItemFase.fromMap(c)).toList() : [];
    return list;
  }

  deleteFase(int id) async {
    final db = await database;
    return db.delete("Fase", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.delete("Fase");
    debugPrint("---------------------apagou------------------------------");
  }
}