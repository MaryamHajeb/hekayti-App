import 'dart:async';
import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';

import 'package:hikayati_app/core/util/common.dart';
import 'package:hikayati_app/features/Regestrion/date/model/CompletionModel.dart';
import 'package:hikayati_app/features/Story/date/model/accuracyModel.dart';
import 'package:intl/intl.dart';
import 'package:hikayati_app/features/Story/date/model/StoryMediaModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import '../../dataProviders/network/data_source_url.dart';
import '../../dataProviders/remote_data_provider.dart';
import '../../features/Home/data/model/StoryMode.dart';
import '../../features/Home/data/model/WebStoryMode.dart';
import '../../features/Home/data/repository/StoryRepository.dart';
import '../../features/Regestrion/date/model/userMode.dart';
import '../../injection_container.dart';
import '../../main.dart';

class DatabaseHelper {
  Database? _db;
  var path;

  String TableName = 'meadia';
  StoryRepository? dd;
  UserModel? userModel = getCachedDate('UserInformation', UserModel.init());

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await intDB();
    return _db;
  }

  intDB() async {
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, "app.db");

// Delete any existing database:

// Create the writable database file from the bundled demo database file:
//     ByteData data = await rootBundle.load(Assets.db.hakity);
//     List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//     await File(dbPath).writeAsBytes(bytes);
    print('create databases secsses');
    var db = await openDatabase(dbPath, onCreate: _onCreate, version: 1);
    path = dbPath;
    print('open databases secsses');
    print(db.isOpen);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('''
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
       ''');

    await db.execute('''
CREATE TABLE "stories_media" (
	"id"	INTEGER,
	"page_no"	INTEGER,
	"story_id"	INTEGER,
	"image"	TEXT,
	"audio"	TEXT,
	"text"	TEXT,
	"text_no_desc"	TEXT,
	"updated_at"	TEXT,
	FOREIGN KEY("story_id") REFERENCES "stories"("id"),
	PRIMARY KEY("id" AUTOINCREMENT)
)
       
       ''');

    await db.execute('''
       
CREATE TABLE "accuracy" (
	"id"	INTEGER,
	"accuracy_stars"	INTEGER,
	"media_id"	INTEGER,
	"readed_text"	TEXT,
	"updated_at"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("media_id") REFERENCES "stories_media"("id") ON DELETE CASCADE
)

       ''');

    await db.execute('''
CREATE TABLE "completion" (
	"id"	INTEGER,
	"stars"	INTEGER,
	"story_id"	INTEGER,
	"updated_at"	TEXT,
	"percentage"	TEXT,
	FOREIGN KEY("story_id") REFERENCES "stories"("id") ON DELETE CASCADE,
	PRIMARY KEY("id" AUTOINCREMENT)
)
       
       ''');
  }

  getReport() async {
    var dbClient = await db;
    List<dynamic> result = await dbClient!.rawQuery(
        'SELECT stories.*,completion.stars,completion.percentage from stories JOIN completion on stories.id==completion.story_id');
    return result.toList();
  }

  Future<int> insert({required dynamic data, required String tableName}) async {
    var dbClient = await db;
    int result = await dbClient!.insert("$tableName", data.toJson());
    print('inseted');
    print(result);
    return result;
  }

  Future<int> update(
      {required data, required String tableName, required String where}) async {
    var dbClient = await db;
    int result =
        await dbClient!.update("$tableName", data.toJson(), where: where);
    print('updated');
    print(result);
    return result;
  }

  Future<List<dynamic>> getAllstory(tableName, level) async {
    Database? dbClient = await db;
    var sql =
        "SELECT * FROM $tableName where level =$level  order by story_order ";

    List<dynamic> result = await dbClient!.rawQuery(sql);
    print(result);

    return result.toList();
  }

  Future<List<dynamic>> getAllReportChart(id) async {
    Database? dbClient = await db;
    var sql =
        "select stories_media.*,accuracy.readed_text,accuracy.accuracy_stars from stories_media JOIN accuracy on stories_media.id==accuracy.media_id WHERE stories_media.story_id==$id ";

    List<dynamic> result = await dbClient!.rawQuery(sql);

    return result.toList();
  }

  Future<String> getStoryStars(level, id) async {
    Database? dbClient = await db;
    List<dynamic> result2 = await dbClient!
        .rawQuery("SELECT stars FROM completion WHERE story_id =$id ");
    print(result2);
    print('result2');
    if (result2.isNotEmpty ?? true) {
      return result2[0]['stars'].toString();
    }
    if (result2.isEmpty ?? true) {
      return '';
    }

    return '';
  }

  checkSlidFound(id) async {
    Database? dbClient = await db;
    var sql = '''
  SELECT id from accuracy WHERE media_id =$id 
    ''';

    var result = await dbClient!.rawQuery(sql);
    print(result);
    print('ggggggggggggggggggggggg');

    if (result.isEmpty == true) {
      return 0;
    } else {
      return result[0]['id'];
    }
  }

  Future<List> getAllSliedForStory(String table, where_arg) async {
    Database? dbClient = await db;

    List<dynamic> result =
        await dbClient!.query(table, where: 'story_id=$where_arg');
    print(result);
    return await result.toList();
  }

  Future<int> deleteTable(table_name) async {
    var dbClient = await db;
    int result = await dbClient!.rawDelete('DELETE FROM $table_name');
    return result;
  }

  checkStoryFound() async {
    List<StoryModel> data = await RemoteDataProvider(client: sl()).sendData(
        url: DataSourceURL.getAllStory,
        body: {},
        retrievedDataType: StoryModel.init(),
        returnType: List);

    data.forEach((element) async {
      dynamic localdata = await foundRecord('id', element.id, 'stories');

      if (await localdata != null) {
        // print(element.updated_at);
        // print('kkkkkkkkkkkkkkkkkkkkkkkkkk');
        if (checkUpdate(element.updated_at.toString(),
                localdata[0]['updated_at'].toString()) !=
            0) {
          print('record  exits');
          // update(data:
          //
          // WebStoryModel(
          //     id: element.id,
          //     cover_image: element.cover_image,
          //     updated_at: element.updated_at,
          //     author: element.author, level: element.level, required_stars: element.required_stars, name: element.name, story_order: '0'),
          //     tableName: 'stories',
          //     where: 'id=${element.id}'
          //
          // );
        }
      } else {
        insert(
            tableName: 'stories',
            data: WebStoryModel(
                download: 0,
                cover_photo: element.cover_photo,
                updated_at: element.updated_at,
                story_order: element.story_order,
                author: element.author,
                level: element.level,
                required_stars: element.required_stars,
                name: element.name,
                id: element.id));
      }
    });
  }

  checkMediaFound() async {
    List<StoryMediaModel> data = await RemoteDataProvider(client: sl())
        .sendData(
            url: DataSourceURL.getAllmedia,
            body: {},
            retrievedDataType: StoryMediaModel.init(),
            returnType: List);

    data.forEach((element) async {
      dynamic localdata = await foundRecord('id', element.id, 'stories_media');

      if (await localdata != null) {
        if (checkUpdate(element.updated_at.toString(),
                localdata[0]['updated_at'].toString()) !=
            0) {
          print('record exits');
        }
      } else {
        insert(
          tableName: 'stories_media',
          data: StoryMediaModel(
              story_id: element.story_id,
              text_no_desc: element.text_no_desc,
              image: element.image,
              audio: element.audio,
              text: element.text,
              updated_at: element.updated_at,
              page_no: element.page_no),
        );
      }
    });
  }

  downloadStoriesCover() async {
    try {
      var dbClient = await db;
      List<String> imageList = [];
      final status = await Permission.storage.request();
      final status2 = await Permission.accessMediaLocation.request();
      List<dynamic> result =
          await dbClient!.rawQuery('SELECT cover_photo from stories  ');
      print(result.length);
      print('cover');
      final Directory? dir = await getApplicationDocumentsDirectory();
      final externalDirectoryPath = Directory('${dir!.path}');
      //  var externalDirectoryPath = await AndroidPathProvider.downloadsPath;
      path = externalDirectoryPath.toString();
      print('============================================================');
      print(externalDirectoryPath.toString());
      // await dirFound(downloadsDirectory.path);

      if (status.isGranted || status2.isGranted) {
        result.forEach((element) async {
          print(element['cover_photo']);
          print(path + '/' + result.first['cover_photo']);
          print('path+ result.first[');
          bool isFound =
              await dirFound(path + '/' + result.first['cover_photo']);
          if (isFound == false) {
            externalDirectoryPath.create(recursive: true);
            fileDownload(
                DataSourceURL.baseDownloadUrl +
                    DataSourceURL.cover +
                    element['cover_photo'],
                externalDirectoryPath.path);
          }
          // imageList.add(DataSourceURL.baseDownloadUrl + DataSourceURL.cover + element['cover_photo']);
        });

        //fileDownload(result[0]['cover_photo'],dir.path );
        await Future.delayed(Duration(seconds: 1));
      }

      print(imageList);
      print('imageList');

      // result.forEach((element){
      //   fileDownload(element['cover_photo'].toString(),path);
      // });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> dirFound(savePath) async {
    if (await File(savePath).exists()) {
      print('file is exite');

      return true;
    } else {
      print('file is not exite');

      return false;
    }
  }

  downloadMedia(String storyId) async {
    var dbClient = await db;
    List<String> imageList = [];
    List<String> audioList = [];
    print('downloadMedia');
    final status = await Permission.storage.request();
    final status2 = await Permission.accessMediaLocation.request();
    List<dynamic> result = await dbClient!.rawQuery(
        'SELECT image,audio from stories_media where story_id=$storyId');
    final Directory? externalDirectoryPath =
        await getApplicationDocumentsDirectory();
    //     final Directory? dir = await getApplicationDocumentsDirectory();
    //  var externalDirectoryPath = await AndroidPathProvider.downloadsPath;
    path = externalDirectoryPath.toString();

    //await dirFound(downloadsDirectory.path);

    if (status.isGranted || status2.isGranted) {
      int update = await dbClient.rawUpdate(
          'UPDATE stories SET download = ? WHERE id = ?', ['1', storyId]);
      result.forEach((element) {
        print(element['cover_photo']);
        fileDownload(
            DataSourceURL.baseDownloadUrl +
                DataSourceURL.photo +
                element['image'],
            externalDirectoryPath!.path);
        fileDownload(
            DataSourceURL.baseDownloadUrl +
                DataSourceURL.sound +
                element['audio'],
            externalDirectoryPath!.path);

        // imageList.add(DataSourceURL.baseDownloadUrl + DataSourceURL.photo + element['photo']);
        // audioList.add(DataSourceURL.baseDownloadUrl + DataSourceURL.audio + element['audio']);
      });

      bool isFound = await dirFound(path + '/' + result.first['photo']);
      if (isFound == false) {
        // fileDownload(imageList,externalDirectoryPath!.path);
        // fileDownload(audioList,externalDirectoryPath!.path);
      }

      print(
          'object==============================================================');
    }
  }

  fileDownload(String urls, String path) async {
    try {
      // final taskId = await FlutterDownloader.enqueue(
      //   url: urls,
      //   headers: {}, // optional: header send with url (auth token etc)
      //   savedDir: path,
      //   showNotification:
      //       true, // show download progress in status bar (for Android)
      //   openFileFromNotification:
      //       true, // click on notification to open downloaded file (for Android)
      // );
      if (!await File(path + "/" + basename(urls)).exists()) {
        var response = await http.get(Uri.parse(urls));
        if (response.statusCode == 200) {
          File('${path + "/" + basename(urls)}')
              .writeAsBytesSync(response.bodyBytes);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //GET DATA ACCUR
  // ACY FROM REMOTE DATABASE INSERTED OR UPDATE
  checkAccuracyFound(List<accuracyModel> data) async {
    int ruslt = 0;

    data.forEach((element) async {
      dynamic localdata =
          await foundRecord('media_id', element.media_id, 'accuracy');
      if (await localdata != null) {
        if (checkUpdate(element.updated_at.toString(),
                localdata[0]['updated_at'].toString()) !=
            0) {
          update(
              data: accuracyModel(
                  id: localdata[0]['id'],
                  media_id: element.media_id,
                  readed_text: element.readed_text,
                  accuracy_stars: element.accuracy_stars,
                  updated_at: element.updated_at),
              tableName: 'accuracy',
              where: 'id=${localdata[0]['id']}');
        }
      } else {
        ruslt = await insert(
          tableName: 'accuracy',
          data: accuracyModel(
              media_id: element.media_id,
              readed_text: element.readed_text,
              accuracy_stars: element.accuracy_stars,
              updated_at: element.updated_at),
        );
      }
    });
  }

  //UPDATE AND INSERT ACCURACY FROM LOCALY
  addAccuracy(accuracyModel data) async {
    print(userModel!.id);
    print('userModel!.id');
    int ruslt = 0;
    dynamic localdata =
        await foundRecord('media_id', data.media_id, 'accuracy');
    if (await localdata != null) {
      // print(element.updated_at);
      // print('kkkkkkkkkkkkkkkkkkkkkkkkkk');
      if (data.accuracy_stars > localdata[0]['accuracy_stars']) {
        update(
            data: accuracyModel(
                id: localdata[0]['id'],
                media_id: data.media_id,
                readed_text: data.readed_text,
                accuracy_stars: data.accuracy_stars,
                updated_at: data.updated_at),
            tableName: 'accuracy',
            where: 'id=${localdata[0]['id']}');

        var remoteData_accruacy =
            await RemoteDataProvider(client: sl()).sendData(
                url: DataSourceURL.uploadAccuracy,
                body: {
                  'user_id': userModel!.id,
                  'updated_at': data.updated_at,
                  'readed_text': data.readed_text,
                  'media_id': data.media_id,
                  'accuracy_stars': data.accuracy_stars
                },
                retrievedDataType: String,
                returnType: String);
      }
    } else {
      ruslt = await insert(
        tableName: 'accuracy',
        data: accuracyModel(
            media_id: data.media_id,
            readed_text: data.readed_text,
            accuracy_stars: data.accuracy_stars,
            updated_at: data.updated_at),
      );

      if (await networkInfo.isConnected && userModel!.id != null) {
        String remoteData_accruacy =
            await RemoteDataProvider(client: sl()).sendData(
                url: DataSourceURL.updateAccuracy,
                body: {
                  'user_id': userModel!.id.toString(),
                  'updated_at': data.updated_at,
                  'readed_text': data.readed_text,
                  'media_id': data.media_id.toString(),
                  'accuracy_stars': data.accuracy_stars.toString()
                },
                retrievedDataType: String,
                returnType: String);
      }
    }

    return ruslt;
  }

  //UPLODE DATA FROM LOCALY IF THE USER WORK THE STORY BUT NOT LOGIN
  uploadAccuracy(String user_id) async {
    Database? dbClient = await db;
    var sql = "SELECT * FROM accuracy";
    var result;
    List<dynamic> res = await dbClient!.rawQuery(sql);

    res.forEach((element) async {
      if (await networkInfo.isConnected) {
        result = await RemoteDataProvider(client: sl()).sendData(
          url: DataSourceURL.uploadAccuracy,
          body: {
            'user_id': user_id,
            'updated_at': element['updated_at'].toString(),
            'readed_text': element['readed_text'].toString(),
            'media_id': element['media_id'].toString(),
            'accuracy_stars': element['accuracy_stars'].toString()
          },
          retrievedDataType: String,
          returnType: String,
        );
      }

      print(result);
    });
    await Future.delayed(Duration(seconds: 1));

    print(res);
  }

  getPercentage(String id) async {
    int stars = 0;
    int percentage = 0;
    Database? dbClient = await db;

    List<dynamic> star = await dbClient!.rawQuery(
        'select accuracy.accuracy_stars from stories_media join accuracy on stories_media.id=accuracy.media_id  where stories_media.story_id = $id ');
    star.forEach((element) {
      stars += int.parse(element['accuracy_stars'].toString());
    });

    print(stars);

    print('all stars is ');
    print(star.length);
    percentage = ((stars / (star.length * 3)) * 100).toInt();
    print(percentage);
    print('percentage in fun');
    return percentage;
  }

  checkCompletionFound(List<CompletionModel> data) async {
    data.forEach((element) async {
      dynamic localdata =
          await foundRecord('story_id', element.story_id, 'completion');

      if (await localdata != null) {
        if (checkUpdate(element.updated_at.toString(),
                localdata[0]['updated_at'].toString()) !=
            0) {
          update(data: {
            'id': localdata[0]['id'],
            'stars': element.stars,
            'percentage': element.percentage,
            'story_id': element.story_id,
            'updated_at': element.updated_at,
          }, tableName: 'completion', where: 'id=${localdata[0]['id']}');
        }
      } else {
        insert(
            tableName: 'completion',
            data: CompletionModel(
              story_id: element.story_id,
              stars: element.stars,
              percentage: element.percentage,
              updated_at: element.updated_at,
              id: element.id,
            ));
      }
    });
  }

  addCompletion(CompletionModel data) async {
    dynamic localdata =
        await foundRecord('story_id', data.story_id, 'completion');
    print(localdata[0]['id']);
    print('localdata[0]');
    if (await localdata != null) {
      if (int.parse(data.stars.toString()) >
              int.parse(localdata[0]['stars'].toString()) ||
          int.parse(data.percentage.toString()) >
              int.parse(localdata[0]['percentage'])) {
        update(
            data: CompletionModel(
                id: localdata[0]['id'],
                updated_at: data.updated_at,
                percentage: data.percentage,
                story_id: data.story_id,
                stars: data.stars),
            tableName: 'completion',
            where: 'id=${localdata[0]['id']}');

        if (await networkInfo.isConnected && userModel!.id != null) {
          var remoteData_completion =
              await RemoteDataProvider(client: sl()).sendData(
                  url: DataSourceURL.updateCompletion,
                  body: {
                    'user_id': userModel!.id,
                    'stars': data.stars,
                    'percentage': data.percentage,
                    'story_id': data.story_id,
                    'updated_at': data.updated_at,
                  },
                  retrievedDataType: String,
                  returnType: String);
        } else {
          // listCopmletion.add({
          //   'id':data.id,
          //    'status':'update',
          // });
        }
      }
    } else {
      insert(
          tableName: 'completion',
          data: CompletionModel(
              updated_at: data.updated_at,
              percentage: data.percentage,
              story_id: data.story_id,
              stars: data.stars));

      if (await networkInfo.isConnected && userModel!.id != null) {
        var remoteData_accruacy =
            await RemoteDataProvider(client: sl()).sendData(
                url: DataSourceURL.uploadCompletion,
                body: {
                  'user_id': userModel!.id.toString(),
                  'stars': data.stars.toString(),
                  'percentage': data.percentage.toString(),
                  'story_id': data.story_id.toString(),
                  'updated_at': data.updated_at,
                },
                retrievedDataType: String,
                returnType: String);
      } else {
        // listCopmletion.add({
        //   'id':data.id,
        //   'status':'insert',
        // });
      }
    }
  }

  //UPLODE DATA FROM LOCALY IF THE USER WORK THE STORY BUT NOT LOGIN
  //tableNme and data
  uploadCompletion(String user_id) async {
    Database? dbClient = await db;
    var sql = "SELECT * FROM completion";
    List<dynamic> res = await dbClient!.rawQuery(sql);

    res.forEach((element) async {
      if (await networkInfo.isConnected) {
        var result = RemoteDataProvider(client: sl()).sendData(
            url: DataSourceURL.uploadCompletion,
            body: {
              'user_id': user_id,
              'updated_at': element['updated_at'].toString(),
              'percentage': element['percentage'].toString(),
              'story_id': element['story_id'].toString(),
              'stars': element['stars'].toString()
            },
            retrievedDataType: String,
            returnType: String);
      }
    });
  }

  Future<dynamic> foundRecord(col, id, table_name) async {
    Database? dbClient = await db;
    List<dynamic> result2 =
        await dbClient!.rawQuery("SELECT * FROM $table_name WHERE $col =$id ");

    if (result2.isNotEmpty) {
      return result2;
    } else {
      return null;
    }
  }

  initApp(String level, String id) async {
    final status = await Permission.storage.request();
    final status2 = await Permission.accessMediaLocation.request();
    Database? dbClient = await db;

    await checkStoryFound();
    await checkMediaFound();
    await downloadStoriesCover();
    print(level);
    List<dynamic> storyId = await dbClient!.rawQuery(
        'SELECT id FROM stories where level = $level  AND story_order = $id ');
    print(storyId);
    print(
        'storyId====================================================================================');
    await downloadMedia(storyId[0]['id'].toString());
    await Future.delayed(Duration(seconds: 5));
  }

  syncApp(
    String level,
  ) async {
    await checkStoryFound();
    await checkMediaFound();
    await downloadStoriesCover();
    //
    // if(userModel!.id!=null){
    //   updateUserDate(userModel!);
    //   // if(listCopmletion.isNotEmpty==true){
    //   //   syncCompletion(listCopmletion,userModel!.id);
    //   //
    //   // }
    // }
    //completion list is not empty =>syncCompletion
    //updateUser
  }

  syncCompletion(List<dynamic> list, user_id) async {
    Database? dbClient = await db;

    var remoteData_completion = [];
    list.forEach((element) async {
      var sql = "SELECT * FROM completion where id=$element['id']";
      List<dynamic> data = await dbClient!.rawQuery(sql);

      element['status'] == 'update'
          ? {
              if (await networkInfo.isConnected && userModel!.id != null)
                {
                  remoteData_completion =
                      await RemoteDataProvider(client: sl()).sendData(
                          url: DataSourceURL.updateCompletion,
                          body: {
                            'user_id': user_id,
                            'stars': element['stars'],
                            'percentage': element['percentage'],
                            'story_id': element['story_id'],
                            'updated_at': element['updated_at']
                          },
                          retrievedDataType: String,
                          returnType: String)
                }
            }
          : {
              remoteData_completion =
                  await RemoteDataProvider(client: sl()).sendData(
                      url: DataSourceURL.uploadCompletion,
                      body: {
                        'user_id': user_id,
                        'stars': element['stars'],
                        'percentage': element['percentage'],
                        'story_id': element['story_id'],
                        'updated_at': element['updated_at'],
                      },
                      retrievedDataType: String,
                      returnType: String)
            };
    });
  }

  int checkUpdate(String update_at_remote, String update_at_local) {
    // print(update_at_remote);
    // print('update_at_remote-----------------');
    // print(update_at_local);
    update_at_remote = update_at_remote.replaceAll('T', ' ');
    update_at_local = update_at_local.replaceAll('T', ' ');
    update_at_local = update_at_local.replaceRange(
        update_at_local.indexOf('.'), update_at_local.length - 1, '');
    update_at_remote = update_at_remote.replaceRange(
        update_at_remote.indexOf('.'), update_at_remote.length - 1, '');

    DateTime dateTime1 =
        DateFormat('yyyy-MM-dd HH:mm:ss').parse(update_at_remote);
    DateTime dateTime2 =
        DateFormat('yyyy-MM-dd HH:mm:ss').parse(update_at_local);

    // print(dateTime1);
    // print(dateTime2);
    int comparison = dateTime1.compareTo(dateTime2);

    return comparison;
  }

  CompletionExits(String story_id) async {
    Database? dbClient = await db;
    CompletionModel? data;
    List<dynamic> reslut = await dbClient!
        .rawQuery('select * from Completion where story_id = $story_id');
    if (reslut != null) {
      reslut.forEach((element) {
        data = CompletionModel(
            updated_at: element['updated_at'],
            percentage: element['percentage'],
            story_id: element['story_id'],
            stars: element['stars']);
      });
    } else {
      data = null;
    }
    return data;
  }

  updateUserDate(UserModel user) async {
    await RemoteDataProvider(client: sl()).sendData(
        url: DataSourceURL.updateuser,
        body: {
          'updated_at': DateFormat('yyyy-MM-ddTHH:mm:ss.ssssZ')
              .format(DateTime.now().toUtc())
              .toString(),
          'email': user.email,
          'id': user.id,
          'level': user.level.toString(),
          'character': user.character.toString(),
          'password': user.password.toString(),
          'user_name': user.user_name.toString(),
        },
        retrievedDataType: String,
        returnType: String);
  }
}
