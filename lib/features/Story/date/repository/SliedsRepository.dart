import 'package:hikayati_app/dataProviders/local_data_provider.dart';
import 'package:hikayati_app/dataProviders/network/Network_info.dart';
import 'package:hikayati_app/dataProviders/remote_data_provider.dart';
import 'package:hikayati_app/dataProviders/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hikayati_app/features/Story/date/model/StoryMediaModel.dart';

import '../../../../core/util/database_helper.dart';
import '../../../../dataProviders/error/failures.dart';

class SliedRepository extends Repository {
  final RemoteDataProvider remoteDataProvider; //get the data from the internet
  final LocalDataProvider localDataProvider; //get the data from the local cache
  final NetworkInfo networkInfo; //check if the device is connected to internet
  DatabaseHelper db = new DatabaseHelper();

  SliedRepository({
    required this.remoteDataProvider,
    required this.localDataProvider,
    required this.networkInfo,
  });

  Future<Either<Failure, dynamic>> getAllSlied(
      {required String story_id, required String tableName}) async {
    return await sendRequest(
        checkConnection: networkInfo.isConnected,
        remoteFunction: () async {
          List<StoryMediaModel> list = [];

          List<dynamic> reslet =
              await db.getAllSliedForStory(tableName, story_id);
          await Future.delayed(Duration(seconds: 1));

          reslet.forEach((element) {
            StoryMediaModel story = StoryMediaModel.fromJson(element);

            list.add(story);
          });

          print(list.length);
          print("list.length");
          return list;
        },
        getCacheDataFunction: () async {
          List<dynamic> reslet =
              await db.getAllSliedForStory(tableName, story_id);
          List<StoryMediaModel> list = [];
          reslet.forEach((element) {
            StoryMediaModel story = StoryMediaModel.fromJson(element);
            list.add(story);
          });

          return list;
        });
  }
}
