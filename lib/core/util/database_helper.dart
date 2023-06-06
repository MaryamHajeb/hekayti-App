import 'dart:async';
import 'dart:io';
import 'package:hikayati_app/features/Story/date/model/accuracyModel.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:hikayati_app/features/Story/date/model/StoryMediaModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../../dataProviders/remote_data_provider.dart';
import '../../features/Home/data/model/StoryMode.dart';
import '../../features/Home/data/model/WebStoryMode.dart';
import '../../features/Regestrion/date/model/userMode.dart';
import '../../gen/assets.gen.dart';


class DatabaseHelper{
   Database? _db ;
   var path;
String TableName='meadia';
 RemoteDataProvider? remoteDataProvider;
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
//     ByteData data = await rootBundle.load(Assets.db.hakity);
//     List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//     await File(dbPath).writeAsBytes(bytes);
    print('create databases secsses');
    var db = await openDatabase(dbPath,onCreate: _onCreate,version: 1);
    path=dbPath;
    print('open databases secsses');
    print(db.isOpen);
    return db;
  }


  void _onCreate(Database db , int newVersion) async{

     await db.execute(
       '''
     CREATE TABLE "stories" (
	"id"	INTEGER,
	"name"	TEXT,
	"cover_photo"	TEXT,
	"author"	TEXT,
	"level"	INTEGER,
	"story_order"	INTEGER,
	"required_stars"	INTEGER,
	"updated_at"	TEXT,
	"download"	BLOB DEFAULT 'false',
	PRIMARY KEY("id" AUTOINCREMENT)
)  
       '''
     );

     await db.execute(
       '''
CREATE TABLE "stories_media" (
	"id"	INTEGER,
	"page_no"	INTEGER,
	"story_id"	INTEGER,
	"photo"	TEXT,
	"sound"	TEXT,
	"text"	TEXT,
	"text_no_dec"	TEXT,
	"updated_at"	TEXT,
	FOREIGN KEY("story_id") REFERENCES "stories"("id"),
	PRIMARY KEY("id" AUTOINCREMENT)
)
       
       '''
     );


     await db.execute(
       '''
       
CREATE TABLE "accuracy" (
	"id"	INTEGER,
	"accuracy_stars"	INTEGER,
	"media_id"	INTEGER,
	"readed_text"	TEXT,
	"updated_at"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("media_id") REFERENCES "stories_media"("id") ON DELETE CASCADE
)

       '''
     );

     await db.execute(
       '''
CREATE TABLE "completion" (
	"id"	INTEGER,
	"stars"	INTEGER,
	"story_id"	INTEGER,
	"updated_at"	TEXT,
	"percentage"	TEXT,
	FOREIGN KEY("story_id") REFERENCES "stories"("id") ON DELETE CASCADE,
	PRIMARY KEY("id" AUTOINCREMENT)
)
       
       '''
     );
  }

getReport()async{
  var dbClient = await  db;
  List<dynamic> result = await dbClient!.rawQuery('SELECT stories.*,completion.stars,completion.percentage from stories JOIN completion on stories.id==completion.story_id');
return result.toList();
  }

Future<int> insert({required dynamic data,required String tableName}) async{
    var dbClient = await  db;
    int result = await dbClient!.insert("$tableName", data.toJson());
    print('inseted');
    print(result);
    return result;
}

Future<int> update({required  data,required String tableName,required String where}) async{
    var dbClient = await  db;
    int result = await dbClient!.update("$tableName", data.toJson(),where:where);
    print('updated');
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


  checkStoryFound(List<StoryModel> data)async{

    data.forEach((element) async{
    dynamic localdata=await foundRecord('id',element.id,'stories');

  if(await localdata!=null){
    // print(element.updated_at);
    // print('kkkkkkkkkkkkkkkkkkkkkkkkkk');
     if(checkUpdate(element.updated_at.toString(),localdata[0]['updated_at'].toString())!=0){


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

  checkMediaFound(List<StoryMediaModel> data)async{

    data.forEach((element) async{
    dynamic localdata=await foundRecord('id',element.id,'stories_media');

  if(await localdata!=null){
    // print(element.updated_at);
    // print('kkkkkkkkkkkkkkkkkkkkkkkkkk');
     if(      checkUpdate(element.updated_at.toString(),localdata[0]['updated_at'].toString())!=0){


       update(data:
                  StoryMediaModel(id:element.id,story_id: element.id, photo: element.photo, sound: element.sound, text: element.text, updated_at: element.updated_at, page_no: element.page_no),
           tableName: 'stories_media',
           where: 'id=${element.id}'

       );


     }

  }else{
    insert(tableName: 'stories_media',data:

    StoryMediaModel(story_id: element.id, photo: element.photo, sound: element.sound, text: element.text, updated_at: element.updated_at, page_no: element.page_no),



    );

   }


  });

  }

  checkAccuracyFound(List<accuracyModel> data)async{

    data.forEach((element) async{
      dynamic localdata=await foundRecord('media_id',element.media_id,'accuracy');
      if(await localdata!=null){
        // print(element.updated_at);
        // print('kkkkkkkkkkkkkkkkkkkkkkkkkk');
        if( checkUpdate(element.updated_at.toString(),localdata[0]['updated_at'].toString())!=0){
          update(data:
          accuracyModel(
              id: localdata[0]['id'],
              media_id: element.media_id,
              readed_text: element.readed_text,
              accuracy_stars: element.accuracy_stars,
              updated_at: element.updated_at),
              tableName: 'accuracy',
              where: 'id=${localdata[0]['id']}'

          );


        }

      }else{
        insert(tableName: 'accuracy',data:

        accuracyModel(media_id: element.media_id, readed_text: element.readed_text, accuracy_stars: element.accuracy_stars, updated_at: element.updated_at),



        );

      }


    });

  }
  uploadAccuracy(String user_id)async{
    Database? dbClient = await  db;
    var sql = "SELECT * FROM accuracy";
     List<dynamic> res=     await dbClient!.rawQuery(sql);
     List<dynamic> res2=[];

     res.forEach((element) {
       res2.add(
           {
             'user_id': user_id,
             'updated_at': element['updated_at'],
             'readed_text': 'jjjj',
             'media_id': element['media_id'],
             'accuracy_stars': element['accuracy_stars']
           }
       );

     });




print(res2);

return res2;
  }

  // checkCompletionFound(List<StoryMediaModel> data)async{
  //
  //   data.forEach((element) async{
  //     dynamic localdata=await foundRecord('story_id',element.story_id,'completion');
  //
  //     if(await localdata!=null){
  //       // print(element.updated_at);
  //       // print('kkkkkkkkkkkkkkkkkkkkkkkkkk');
  //       if(checkUpdate(element.updated_at.toString(),localdata[0]['updated_at'].toString())!=0){
  //         update(data:
  //         CompletionModel(),
  //             tableName: 'completion',
  //             where: 'id=${element.id}'
  //
  //         );
  //
  //
  //       }
  //
  //     }else{
  //       insert(tableName: 'completion',data:
  //
  //       CompletionModel(),
  //
  //
  //
  //       );
  //
  //     }
  //
  //
  //   });
  //
  // }
  //




  Future<dynamic> foundRecord(col,id,table_name)async{
    Database? dbClient = await  db;
    List<dynamic> result2 = await dbClient!.rawQuery("SELECT * FROM $table_name WHERE $col =$id ");

    if(result2.isNotEmpty){
      return result2;
    }
    else{
      return null;
    }
  }

 int checkUpdate(String update_at_remote,String update_at_local){

    update_at_remote=  update_at_remote.replaceAll('T', ' ');
    update_at_remote=update_at_remote.replaceRange(update_at_remote.indexOf('.'), update_at_remote.indexOf('Z')+1, '');

    update_at_local=  update_at_local.replaceAll('T', ' ');
    update_at_local=update_at_local.replaceRange(update_at_local.indexOf('.'), update_at_local.indexOf('Z')+1, '');

    // print(update_at_remote);
    // print('update_at_remote-----------------');
    // print(update_at_local);
    DateTime dateTime1 = DateFormat('yyyy-MM-dd HH:mm:ss').parse(update_at_remote);
    DateTime dateTime2 = DateFormat('yyyy-MM-dd HH:mm:ss').parse(update_at_local);
    int comparison = dateTime1.compareTo(dateTime2);


 return comparison;

  }

}