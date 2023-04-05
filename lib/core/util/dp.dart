import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
// ignore: duplicate_import
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqldb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }




  intialDb() async {

    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, "app.db");

// Delete any existing database:
    await deleteDatabase(dbPath);

// Create the writable database file from the bundled demo database file:
    ByteData data = await rootBundle.load("DB/hakity.db");
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
   print('create databases secsses');
    var db = await openDatabase(dbPath);

    print('open databases secsses');

    print(db.database);

    // String databasepath = await getDatabasesPath();
    // String path = join(databasepath,'Gass.db');
    // Database mydb = await openDatabase(path, onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);
    // return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade database and Table==============");
  }

  _onCreate(Database db, int version) async {
  //  String sql = 'CREATE TABLE LOGIN (ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, NAME TEXT, PASSWORD TEXT, AGINPASSWORD TEXT)';
    await db.execute('''                                 
    CREATE TABLE 'LOGIN'(
    ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    USER_NAME TEXT NOT NULL,
    PASSWORD TEXT NOT NULL,
    EMAIL TEXT NOT NULL
   
    )
    
    ''');

    await db.execute('''
    CREATE TABLE 'Users'(
    ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    NAME TEXT NOT NULL,
    NUMBER_PHONE TEXT NOT NULL,
    CARD_NUM TEXT NOT NULL,
    NOTE TEXT
  )
    
    ''');



    await db.execute('''
    CREATE TABLE 'GAS'(
    ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    USER_ID INTEGER ,
    DATE TEXT,
    STATUS INTEGER ,
    GAS_NOTE TEXT NOT NULL
  )
    
    ''');


    //
    // RESTING_DATE TEXT NOT NULL,
    // RETURN_DATE TEXT NOT NULL
    print("create database and Table==============");
  }
  //
  readDate(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }


  updateDate(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }


  getId(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }



  //
  // insertDate(String sql) async {
  //   Database? mydb = await db;
  //   int response = await mydb!.rawInsert(sql);
  //   return response;
  // }
  //
  // updateDate(String sql) async {
  //   Database? mydb = await db;
  //   int response = await mydb!.rawUpdate(sql);
  //   return response;
  // }
  //
  // deleteDate(String sql) async {
  //   Database? mydb = await db;
  //   int response = await mydb!.rawDelete(sql);
  //   return response;
  // }

  
  read_where(String  table,String mywhere,where_arg) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table,where: mywhere,whereArgs: where_arg);
    return response;
  }

  read(String  table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  insert(String table,Map<String,Object> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table,values);
    return response;
  }

  update(String table,Map<String,Object> values,String mywhere) async {
    Database? mydb = await db;
    int response = await mydb!.update(table,values,where: mywhere);
    return response;
  }

  delete(String table,Map<String,Object> values,String mywhere) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table,where: mywhere);
    return response;
  }
}
