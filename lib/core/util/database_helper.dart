import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:hikayati_app/core/util/common.dart';
import 'package:hikayati_app/features/Regestrion/date/model/CompletionModel.dart';
import 'package:hikayati_app/features/Story/date/model/accuracyModel.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:hikayati_app/features/Story/date/model/StoryMediaModel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../../dataProviders/network/data_source_url.dart';
import '../../dataProviders/remote_data_provider.dart';
import '../../features/Home/data/model/StoryMode.dart';
import '../../features/Home/data/model/WebStoryMode.dart';
import '../../features/Home/data/repository/StoryRepository.dart';
import '../../features/Regestrion/date/model/userMode.dart';
import '../../gen/assets.gen.dart';
import '../../injection_container.dart';
import '../../main.dart';


class DatabaseHelper{
   Database? _db ;
   var path;
   List listCopmletion=    CachedDate('listCopmletion', []);

String TableName='meadia';
    StoryRepository? dd;
   UserModel? userModel;

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
	"download"	INTEGER ,
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
	"text_no_desc"	TEXT,
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
  var sql = "SELECT * FROM $tableName where level =$level  order by story_order ";

  List<dynamic> result = await dbClient!.rawQuery(sql);
 print(result);

    return  result.toList();
  }


 Future<List<dynamic>> getAllReportChart(id) async{
    Database? dbClient = await  db;
  var sql = "select stories_media.*,accuracy.readed_text,accuracy.accuracy_stars from stories_media JOIN accuracy on stories_media.id==accuracy.media_id WHERE stories_media.story_id==$id ";

  List<dynamic> result = await dbClient!.rawQuery(sql);


    return  result.toList();
  }



 Future<String> getStoryStars(level,id)async{
  Database? dbClient = await  db;
  List<dynamic> result2 = await dbClient!.rawQuery("SELECT stars FROM completion WHERE story_id =$id ");
   print(result2);
   print('result2');
  if(result2.isNotEmpty ?? true){
    return result2[0]['stars'].toString();

  }
  if(result2.isEmpty ?? true)
{
  return '';
}



return '';

}



   checkSlidFound(id) async{

    Database? dbClient = await  db;
  var sql = '''
  SELECT id from accuracy WHERE media_id =$id 
    ''';

  var result = await dbClient!.rawQuery(sql);
    print(result);
    print('ggggggggggggggggggggggg');

    if(result.isEmpty==true){
    return 0;
  }
  else{
    return result[0]['id'];
  }

  }








   Future<List> getAllSliedForStory(String  table,where_arg) async{
     Database? dbClient = await  db;

     List<dynamic> result = await dbClient!.query(table,where:  'story_id=$where_arg');
     print(result);
     return await result.toList();

   }

Future<int> deleteTable(table_name) async{
    var dbClient = await  db;
    int result = await dbClient!.rawDelete('DELETE FROM $table_name');
    return result;
}


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


  checkStoryFound()async{

    List<StoryModel> data=  await RemoteDataProvider(client: sl()).sendData(url: DataSourceURL.getAllStory, body: {

    }, retrievedDataType: StoryModel.init(),
        returnType: List
    );

    data.forEach((element) async{
    dynamic localdata=await foundRecord('id',element.id,'stories');

  if(await localdata!=null){
    // print(element.updated_at);
    // print('kkkkkkkkkkkkkkkkkkkkkkkkkk');
     if(checkUpdate(element.updated_at.toString(),localdata[0]['updated_at'].toString())!=0){

        print('record  exits');
       // update(data:
       //
       // WebStoryModel(
       //     id: element.id,
       //     cover_photo: element.cover_photo,
       //     updated_at: element.updated_at,
       //     author: element.author, level: element.level, required_stars: element.required_stars, name: element.name, story_order: '0'),
       //     tableName: 'stories',
       //     where: 'id=${element.id}'
       //
       // );


     }

  }else{
    insert(tableName: 'stories',data:
    WebStoryModel(
        download: 0,
        cover_photo: element.cover_photo,
        updated_at: element.updated_at,
        story_order: element.story_order, author: element.author, level: element.level, required_stars: element.required_stars, name: element.name, id: element.id));
   }


  });

  }

  checkMediaFound()async{
    List<StoryMediaModel> data=  await RemoteDataProvider(client: sl()).sendData(url: DataSourceURL.getAllmedia, body: {

    }, retrievedDataType: StoryMediaModel.init(),
        returnType: List
    );

    data.forEach((element) async{
    dynamic localdata=await foundRecord('id',element.id,'stories_media');

if(await localdata!=null){
     if(checkUpdate(element.updated_at.toString(),localdata[0]['updated_at'].toString())!=0){

       print('record exits');


     }

  }else{
    insert(tableName: 'stories_media',data:

    StoryMediaModel(story_id: element.story_id, text_no_desc: element.text_no_desc,photo: element.photo, sound: element.sound, text: element.text, updated_at: element.updated_at, page_no: element.page_no),




    );

   }


  });

  }




  downloadStoriesCover()async{
try {
  var dbClient = await db;
  List<String> imageList=[];
  final status = await Permission.storage.request();
  final status2 = await Permission.manageExternalStorage.request();
  List<dynamic> result = await dbClient!.rawQuery('SELECT cover_photo from stories  ');
  print(result.length);
  print('cover');
  var externalDirectoryPath = await AndroidPathProvider.downloadsPath;;
  path=  externalDirectoryPath.toString();
  print('============================================================');
  print(externalDirectoryPath.toString());
 // await dirFound(downloadsDirectory.path);

  if (status.isGranted || status2.isGranted) {
    result.forEach((element) async {
      print(element['cover_photo']);
      imageList.add(DataSourceURL.baseDownloadUrl + DataSourceURL.cover+element['cover_photo']);

      await Future.delayed(Duration(seconds: 1));
    });
    //fileDownload(result[0]['cover_photo'],dir.path );
    fileDownload(imageList);

  }

  print(imageList);
  print('imageList');

  // result.forEach((element){
  //   fileDownload(element['cover_photo'].toString(),path);
  // });


}catch(e){
  print(e.toString());
}


  }

  downloadMedia(String storyId )async{
    var dbClient = await  db;
    List<String> imageList=[];
    List<String> audioList=[];
print('downloadMedia');
    final status= await Permission.storage.request();



    List<dynamic> result = await dbClient!.rawQuery('SELECT photo,sound from stories_media where story_id=$storyId');
    var externalDirectoryPath = await getExternalStorageDirectory();
    path=  externalDirectoryPath!.path.toString();
    //await dirFound(downloadsDirectory.path);


    if(status.isGranted) {
      int update = await dbClient!.rawUpdate('UPDATE stories SET download = ? WHERE id = ?', ['1',storyId ]);
      result.forEach((element) {
        print(element['cover_photo']);
        imageList.add(DataSourceURL.baseDownloadUrl + DataSourceURL.photo+ element['photo']);
        audioList.add(DataSourceURL.baseDownloadUrl + DataSourceURL.sound+ element['sound']);


     });

      fileDownload(imageList);
      fileDownload(audioList );

      print('object==============================================================');
    }





  }
  fileDownload(List<String> urls,)async{
     try {
       //You can download a single file
       final List<File?> result = await FileDownloader.downloadFiles(
            urls: urls,
           isParallel: true,   //if this is set to true, your download list will request to be downloaded all at once
           //if your downloading queue fits them all, they are all will start downloading
           //if it's set to false, it will download every file individually
           //default is true
           onAllDownloaded: () {
             //This callback will be fired when all files are done
           });
     }catch(e){
       print(e.toString());
     }
  }


  //GET DATA ACCUR
  // ACY FROM REMOTE DATABASE INSERTED OR UPDATE
  checkAccuracyFound(List<accuracyModel> data)async{
         int ruslt=0;

    data.forEach((element) async{
      dynamic localdata=await foundRecord('media_id',element.media_id,'accuracy');
      if(await localdata!=null){
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
        ruslt=await insert(tableName: 'accuracy',data: accuracyModel(media_id: element.media_id, readed_text: element.readed_text, accuracy_stars: element.accuracy_stars, updated_at: element.updated_at),
        );
      }
    });
  }


  //UPDATE AND INSERT ACCURACY FROM LOCALY
  addAccuracy(accuracyModel data)async{
        int ruslt=0;
      dynamic localdata=await foundRecord('media_id',data.media_id,'accuracy');
      if(await localdata!=null) {
        // print(element.updated_at);
        // print('kkkkkkkkkkkkkkkkkkkkkkkkkk');
        if (data.accuracy_stars >
            localdata[0]['accuracy_stars']) {
          update(data:
          accuracyModel(
              id: localdata[0]['id'],
              media_id: data.media_id,
              readed_text: data.readed_text,
              accuracy_stars: data.accuracy_stars,
              updated_at: data.updated_at),
              tableName: 'accuracy',
              where: 'id=${localdata[0]['id']}'

          );


          var remoteData_accruacy = await RemoteDataProvider(client: sl()).sendData(url: DataSourceURL.uploadAccuracy, body: {

            'user_id': getCachedDate('User_id', String),
            'updated_at': data.updated_at,
            'readed_text':data.readed_text,
            'media_id': data.media_id,
            'accuracy_stars':data.accuracy_stars

          }, retrievedDataType: String);

        }
      }

      else{
        ruslt=await  insert(tableName: 'accuracy',data:
         accuracyModel(media_id: data.media_id, readed_text: data.readed_text, accuracy_stars: data.accuracy_stars, updated_at: data.updated_at),);

        if(await networkInfo.isConnected &&userModel!= null ) {
          var remoteData_accruacy = await RemoteDataProvider(client: sl())
              .sendData(url: DataSourceURL.updateAccuracy, body: {

            'user_id': getCachedDate('User_id', int),
            'updated_at': data.updated_at,
            'readed_text': data.readed_text,
            'media_id': data.media_id,
            'accuracy_stars': data.accuracy_stars
          }, retrievedDataType: String);
        }

      }
return ruslt;
  }

  //UPLODE DATA FROM LOCALY IF THE USER WORK THE STORY BUT NOT LOGIN
  uploadAccuracy(String user_id)async{
    Database? dbClient = await  db;
    var sql = "SELECT * FROM accuracy";
    var result;
     List<dynamic> res=     await dbClient!.rawQuery(sql);

     res.forEach((element) async{
       if(await networkInfo.isConnected ) {
         result = await RemoteDataProvider(client: sl()).sendData(
             url: DataSourceURL.uploadAccuracy, body: {
           'user_id': user_id,
           'updated_at': element['updated_at'].toString(),
           'readed_text': element['readed_text'].toString(),
           'media_id': element['media_id'].toString(),
           'accuracy_stars': element['accuracy_stars'].toString()
         }, retrievedDataType: String,
         returnType: String,
         );
       }

print(result);

     });
    await Future.delayed(Duration(seconds: 1));



print(res);


  }
     getPercentage(String id)async{
        int stars=0;
        int percentage =0;
       Database? dbClient = await  db;

       List<dynamic> star = await dbClient!.rawQuery('select accuracy.accuracy_stars from stories_media join accuracy on stories_media.id=accuracy.media_id  where stories_media.story_id = $id ');
       star.forEach((element) {
         stars +=int.parse(element['accuracy_stars'].toString());
       });

   print(stars);

   print('all stars is ');
        print(star.length);
       percentage=((stars/star.length).toInt() *100 /2).toInt();
print(percentage);
print('percentage in fun');
       return percentage;
     }

  checkCompletionFound(List<CompletionModel> data)async{

    data.forEach((element) async{
      dynamic localdata=await foundRecord('story_id',element.story_id,'completion');

      if(await localdata!=null){
        if(checkUpdate(element.updated_at.toString(),localdata[0]['updated_at'].toString())!=0){
          update(data:
          {
            'id': localdata[0]['id'],
            'stars':element.stars,
            'percentage':element.percentage,
            'story_id':element.story_id,
            'updated_at':element.updated_at,
          }
              ,
              tableName: 'completion',
              where: 'id=${localdata[0]['id']}'

          );
        }
      }else{
        insert(tableName: 'completion',data:CompletionModel(

            story_id: element.story_id,
            stars: element.stars,
            percentage: element.percentage,
            updated_at: element.updated_at,
            id: element.id,


        )
        );
      }
    });
  }


  addCompletion(CompletionModel data)async{
      dynamic localdata=await foundRecord('story_id',data.story_id,'completion');

      if(await localdata!=null){
        if (int.parse(data.stars.toString()) >
            int.parse(localdata[0]['stars'].toString())){
              update(data:
              {
                'id': localdata[0]['id'],
                'stars':data.stars,
                'percentage':data.percentage,
                'story_id':data.story_id,
                'updated_at':data.updated_at,
              }
                  ,
                  tableName: 'completion',
                  where: 'id=${localdata[0]['id']}'

              );
              checkUserLoggedIn().fold((l) {
                userModel = l;
              }, (r) {
                userModel = null;
              });

              if(await networkInfo.isConnected &&userModel!= null ) {
                var remoteData_completion = await RemoteDataProvider(
                    client: sl()).sendData(
                    url: DataSourceURL.updateCompletion, body: {

                  'user_id': '1',
                  'stars': data.stars,
                  'percentage': data.percentage,
                  'story_id': data.story_id,
                  'updated_at': data.updated_at,

                }, retrievedDataType: String);
              }
              else{
                listCopmletion.add({
                  'id':data.id,
                   'status':'update',                 
                });
                
                
              }



        }

      }else{
        insert(tableName: 'completion',data:CompletionModel(updated_at: data.updated_at, percentage: data.percentage, story_id: data.story_id, stars: data.stars)
        );

        if(await networkInfo.isConnected &&userModel!= null ) {
          var remoteData_accruacy = await RemoteDataProvider(client: sl())
              .sendData(url: DataSourceURL.uploadCompletion, body: {

            'user_id': '1',
            'stars': data.stars,
            'percentage': data.percentage,
            'story_id': data.story_id,
            'updated_at': data.updated_at,

          }, retrievedDataType: String);
        }else{
          // listCopmletion.add({
          //   'id':data.id,
          //   'status':'insert',
          // });
          
        }

      }




    }



  //UPLODE DATA FROM LOCALY IF THE USER WORK THE STORY BUT NOT LOGIN
  //tableNme and data
  uploadCompletion(String user_id)async{
    Database? dbClient = await  db;
    var sql = "SELECT * FROM completion";
    List<dynamic> res=     await dbClient!.rawQuery(sql);



    res.forEach((element) async{

      if(await networkInfo.isConnected) {
        var result = RemoteDataProvider(client: sl()).sendData(
            url: DataSourceURL.uploadCompletion, body: {

          'user_id': user_id,
          'updated_at': element['updated_at'].toString(),
          'percentage': element['percentage'].toString(),
          'story_id': element['story_id'].toString(),
          'stars': element['stars'].toString()
        }, retrievedDataType: String,returnType: String
        );
      }


    });






  }





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


initApp(String level, String id)async{
  final status= await Permission.storage.request();;
  final status2= await Permission.manageExternalStorage.request();
  Database? dbClient = await  db;

  await checkStoryFound();
  await checkMediaFound();
  await downloadStoriesCover();
  print(level);
  List<dynamic> storyId = await dbClient!.rawQuery('SELECT id FROM stories where level = $level  AND story_order = $id ');
  print(storyId);
  print('storyId====================================================================================');
  await downloadMedia(storyId[0]['id'].toString());

  }

syncApp(String level,)async{
  checkUserLoggedIn().fold((l) {
    userModel = l;
  }, (r) {
    userModel = null;
  }) ;
    checkStoryFound();
     checkMediaFound();
     await downloadStoriesCover();


     if(userModel!=null){
       updateUserDate(userModel!);
       if(listCopmletion.isNotEmpty==true){

         syncCompletion(listCopmletion,userModel!.id);


       }
     }
      //completion list is not empty =>syncCompletion
      //updateUser


   }


   syncCompletion(List<dynamic> list,user_id) async{
     Database? dbClient = await  db;

     var remoteData_completion=[];
     list.forEach((element) async{
       var sql = "SELECT * FROM completion where id=$element['id']";
       List<dynamic> data=await dbClient!.rawQuery(sql) as List;

       element['status']=='update'?
       {
       if(await networkInfo.isConnected &&userModel!= null ) {

         remoteData_completion =
         await RemoteDataProvider(client: sl()).sendData(
             url: DataSourceURL.updateCompletion, body: {
           'user_id': user_id,
           'stars': element['stars'],
           'percentage': element['percentage'],
           'story_id': element['story_id'],
           'updated_at': element['updated_at']
         }, retrievedDataType: String)
       }
       }



           :{remoteData_completion =  await RemoteDataProvider(client: sl()).sendData(url: DataSourceURL.uploadCompletion,
       body: {
       'user_id': '1',
       'stars':element['stars'],
       'percentage':element['percentage'],
       'story_id':element['story_id'],
       'updated_at':element['updated_at'],
       },
       retrievedDataType: String
       )};
     });
   }



 int checkUpdate(String update_at_remote,String update_at_local){

    // print(update_at_remote);
    // print('update_at_remote-----------------');
    // print(update_at_local);
   update_at_remote =update_at_remote.replaceAll('T', ' ');
   update_at_local =update_at_local.replaceAll('T', ' ');
   update_at_local =update_at_local.replaceRange(update_at_local.indexOf('.'),update_at_local.length-1,'');
   update_at_remote =update_at_remote.replaceRange(update_at_remote.indexOf('.'),update_at_remote.length-1,'');


    DateTime dateTime1 = DateFormat('yyyy-MM-dd HH:mm:ss').parse(update_at_remote);
    DateTime dateTime2 = DateFormat('yyyy-MM-dd HH:mm:ss').parse(update_at_local);

    // print(dateTime1);
    // print(dateTime2);
    int comparison = dateTime1.compareTo(dateTime2);


 return comparison;

  }


 CompletionExits(String story_id)async{
     Database? dbClient = await  db;
     CompletionModel? data;
     List<dynamic> reslut=await   dbClient!.rawQuery('select * from Completion where story_id = $story_id');
      if(reslut!=null ){
         reslut.forEach((element) {
         data=  CompletionModel(updated_at: element['updated_at'], percentage: element['percentage'], story_id: element['story_id'], stars: element['stars']);
         });


      }
      else{
        data=null;
      }
     return data;
}

updateUserDate(UserModel user)async{
   RemoteDataProvider(client: sl()).sendData(
      url: DataSourceURL.updateuser, body: {
    'id': user.id,
    'email': user.email,
    'level': user.level,
    'character': user.character,
    'password': user.password,
    'user_name': user.user_name,
    'update_at': user.update_at,
  }, retrievedDataType: String);

}



}