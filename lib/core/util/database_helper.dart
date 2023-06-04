import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:hikayati_app/features/Story/date/model/MeadiaModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../../features/Home/data/model/StoryMode.dart';
import '../../features/Home/data/model/WebStoryMode.dart';
import '../../features/Regestrion/date/model/userMode.dart';
import '../../gen/assets.gen.dart';


class DatabaseHelper{
   Database? _db ;
   var path;
String TableName='meadia';
  
  Future<Database?> get db async{
    if(_db != null){
      return _db;
    }
    _db = await intDB();
    return _db;
  }


  intDB() async{
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, "app.db");

// Delete any existing database:

// Create the writable database file from the bundled demo database file:
    ByteData data = await rootBundle.load(Assets.db.hakity);
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
    print('create databases secsses');
    var db = await openDatabase(dbPath);
    path=dbPath;
    print('open databases secsses');
    print(db.isOpen);
    return db;
  }

  //
  // void _onCreate(Database db , int newVersion) async{
  //   var sql = "CREATE TABLE user (id INTEGER PRIMARY KEY,"
  //       " name TEXT, password TEXT,  city TEXT, age INTEGER )";
  //    await db.execute(sql);
  // }



Future<int> insert({required dynamic data,required String tableName}) async{
    var dbClient = await  db;
    int result = await dbClient!.insert("$tableName", data.toJson());
    print(result);
    return result;
}
Future<int> update({required WebStoryModel data,required String tableName,required String where}) async{
    var dbClient = await  db;
    int result = await dbClient!.update("$tableName", data.toJson(),where:where);
    print(result);
    return result;
}



 Future<List<dynamic>> getAllstory(tableName, level) async{
    Database? dbClient = await  db;
  var sql = "SELECT * FROM $tableName where level =$level ";

  List<dynamic> result = await dbClient!.rawQuery(sql);


    return  result.toList();
  }



 Future<int> getStoryStars(level,id)async{
  Database? dbClient = await  db;
  List<dynamic> result2 = await dbClient!.rawQuery("SELECT stars FROM completion WHERE story_id =$id ");
  if(result2.isNotEmpty){
    return result2[0]['stars'];
  }
  else{
    return 0;
  }




}



  Future<List> getAllstoryfromdb(tableName) async{

    Database? dbClient = await  db;
  var sql = '''
  SELECT story_id from complation WHERE level =1  
    ''';

  List<dynamic> result = await dbClient!.rawQuery(sql);
  return await result.toList();
  }


   Future<List> getAllSliedForStory(String  table,where_arg) async{
     Database? dbClient = await  db;

     List<dynamic> result = await dbClient!.query(table,where: 'story_id = $where_arg');
     return await result.toList();

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


  checkStoryFound(List<StoryModel> stories)async{

  stories.forEach((element) async{
    dynamic localStory=await foundStory(element.id);

  if(await localStory!=null){
    // print(element.updated_at);
    // print('kkkkkkkkkkkkkkkkkkkkkkkkkk');
     if(      checkUpdate(element.updated_at,localStory[0]['updated_at'])!=0){
                update(data:

                WebStoryModel(
                   id: element.id,
                    cover_photo: element.cover_photo,
                    updated_at: element.updated_at,
                    author: element.author, level: element.level, required_stars: element.required_stars, name: element.name, story_order: '0'),
                    tableName: 'stories',
                    where: 'id=${element.id}'

                );
     }

  }else{
    insert(tableName: 'stories',data:

    WebStoryModel(

        cover_photo: element.cover_photo,
        updated_at: element.updated_at,

        story_order: '', author: element.author, level: element.level, required_stars: element.required_stars, name: element.name, id: element.id));

   }


  });

  }
  Future<dynamic> foundStory(id)async{
    Database? dbClient = await  db;
    List<dynamic> result2 = await dbClient!.rawQuery("SELECT * FROM stories WHERE id =$id ");

    if(result2.isNotEmpty){
      return result2;
    }
    else{
      return null;
    }
  }


 int checkUpdate(String update_at_remote,update_at_local){

    update_at_remote=  update_at_remote.replaceAll('T', ' ');
    update_at_remote=update_at_remote.replaceRange(update_at_remote.indexOf('.'), update_at_remote.indexOf('Z')+1, '');
    print(update_at_remote);
    print('update_at_remote-----------------');
    print(update_at_local);
    DateTime dateTime1 = DateFormat('yyyy-MM-dd HH:mm:ss').parse(update_at_remote);
    DateTime dateTime2 = DateFormat('yyyy-MM-dd HH:mm:ss').parse(update_at_local);
    int comparison = dateTime1.compareTo(dateTime2);
 return comparison;

  }

}