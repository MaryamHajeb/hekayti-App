import 'dart:async';
import 'dart:io';
import 'package:hikayati_app/features/Story/date/model/MeadiaModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../../features/Regestrion/date/model/userMode.dart';


class DatabaseHelper{
  static Database? _db;


  
  Future<Database?> get db async{
    if(_db != null){
      return _db;
    }
    _db = await intDB();
    return _db;
  }


  intDB() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path , 'hakity.db');
    var myOwnDB = await openDatabase(path,version: 1,
        onCreate: _onCreate);
    print('create db sceeses');
    return myOwnDB;
  }
  
  void _onCreate(Database db , int newVersion) async{
    var sql = '''BEGIN TRANSACTION;
    CREATE TABLE IF NOT EXISTS "story" (
        "id"	INTEGER,
        "name"	TEXT,
        "cover_photo"	TEXT,
        "auther"	TEXT
        "level"	INTEGER,
        "required_start"	INTEGER,
        PRIMARY KEY("id")
    );
    CREATE TABLE IF NOT EXISTS "meadia" (
    "id"	INTEGER,
    "page_no"	INTEGER,
    "story_id"	INTEGER,
    "photo"	TEXT,
    "sound"	TEXT,
    "text"	TEXT,
    FOREIGN KEY("story_id") REFERENCES "story"("id"),
    PRIMARY KEY("id" AUTOINCREMENT),
    );
    COMMIT;''';
    try{
      await db.execute(sql);
    }catch(e){
      e.toString();
    }

    print('create teble scees');
  }

Future<int> inserStory( MeadiaModel meadiaModel) async{
    var dbClient = await  db;
    int result = await dbClient!.insert("meadia", meadiaModel.toJson());
    return result;
}



// Future<int> saveUserModel( UserModel UserModel) async{
//     var dbClient = await  db;
//     int result = await dbClient!.insert("$UserModelTable", UserModel.toJson());
//     return result;
// }


  // Future<List> getAllUserModels() async{
  //   var dbClient = await  db;
  //   var sql = "SELECT * FROM $UserModelTable";
  //   List result = await dbClient!.rawQuery(sql);
  //   return result.toList();
  // }
  //
  // Future<int?> getCount() async{
  //   var dbClient = await  db;
  //   var sql = "SELECT COUNT(*) FROM $UserModelTable";
  //
  //   return  Sqflite.firstIntValue(await dbClient!.rawQuery(sql)) ;
  // }

  // Future<List<Map<String, Object?>>> getUserModel(int id) async{
  //   var dbClient = await  db;
  //   var sql = "SELECT * FROM $UserModelTable WHERE $columnId = $id";
  //   var result = await dbClient!.rawQuery(sql);
  //  return result;
  // }


  // Future<int> deleteUserModel(int id) async{
  //   var dbClient = await  db;
  //   return  await dbClient!.delete(
  //       UserModelTable , where: "$columnId = ?" , whereArgs: [id]
  //   );
  // }
  //
  // Future<int> updateUserModel(UserModel UserModel) async{
  //   var dbClient = await  db;
  //   return  await dbClient!.update(
  //  UserModelTable ,UserModel.toJson(), where: "$columnId = ?" , whereArgs: [UserModel.id]
  //   );
  // }
  //
  //
  // Future<void> close() async{
  //   var dbClient = await  db;
  //   return  await dbClient!.close();
  // }
  //

}