import 'package:hikayati_app/dataProviders/local_data_provider.dart';
import 'package:hikayati_app/dataProviders/network/Network_info.dart';
import 'package:hikayati_app/dataProviders/remote_data_provider.dart';
import 'package:hikayati_app/dataProviders/repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/util/common.dart';
import '../../../../dataProviders/error/failures.dart';
import '../../../../main.dart';
import '../../../Home/data/model/StoryMode.dart';

class StoryRepository extends Repository {
  final RemoteDataProvider remoteDataProvider; //get the data from the internet
  final LocalDataProvider localDataProvider; //get the data from the local cache
  final NetworkInfo networkInfo; //check if the device is connected to internet

  StoryRepository({
    required this.remoteDataProvider,
    required this.localDataProvider,
    required this.networkInfo,
  });

  Future<Either<Failure, dynamic>> getAllStory(
    String level,
  ) async {
    return sendRequest(
        checkConnection: networkInfo.isConnected,
        remoteFunction: () async {
          return await getStars(level);
        },
        getCacheDataFunction: () async {
          return await getStars(level);
        });
  }

  Future<List<StoryModel>> getStars(level) async {
    List<dynamic> reslet = await db.getAllstory('stories', level);
    print(reslet.length);
    print('reslet.length');
    List<StoryModel> dd = [];
    int collected_stars = 0;
    int all_stars = reslet.length * 3;

    reslet.forEach((element) async {
      String? start = '';
      start = await db.getStoryStars('1', element['id']) ?? '';
      if (start == '') {
        start = '0';
      }
      print(start);
      print('start++++++++++++++++++++++++++++++++++++');
      collected_stars += int.parse(start);

      dd.add(StoryModel(
          download: element['download'],
          cover_photo: element['cover_photo'],
          author: element['author'],
          level: element['level'],
          required_stars: element['required_stars'],
          name: element['name'],
          stars: start.toString(),
          id: element['id'],
          story_order: element['story_order'],
          updated_at: element['updated_at']));
//      start='';
    });
    await Future.delayed(Duration(seconds: 1));
    print(collected_stars);
    print(all_stars);
    print('all_stars');
    CachedDate('all_stars', all_stars);
    CachedDate('collected_stars', collected_stars);
    return dd;
  }
}
