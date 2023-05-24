import 'dart:developer';

import 'package:hikayati_app/dataProviders/local_data_provider.dart';
import 'package:hikayati_app/dataProviders/network/Network_info.dart';
import 'package:hikayati_app/dataProviders/network/data_source_url.dart';
import 'package:hikayati_app/dataProviders/remote_data_provider.dart';
import 'package:hikayati_app/dataProviders/repository.dart';
import 'package:dartz/dartz.dart';


import '../../../../core/util/database_helper.dart';
import '../../../../dataProviders/error/exceptions.dart';
import '../../../../dataProviders/error/failures.dart';
import '../model/StoryMode.dart';

class StoryRepository extends Repository{
  final RemoteDataProvider remoteDataProvider; //get the data from the internet
  final LocalDataProvider localDataProvider; //get the data from the local cache
  final NetworkInfo networkInfo; //check if the device is connected to internet
  DatabaseHelper db = new DatabaseHelper();

  StoryRepository({
    required this.remoteDataProvider,
    required this.localDataProvider,
    required this.networkInfo,
  });


  Future<Either<Failure, dynamic>> getAllStory({required String token}) async {
    return await sendRequest(

        checkConnection: networkInfo.isConnected,

        remoteFunction: () async {
          List<dynamic> reslet = await db.getAllstory('story');
          List<StoryModel> list=[] ;
          reslet.forEach((element) {
            StoryModel user = StoryModel.fromJson(element);
            list.add(user);
          });


          return  list;;

          // localDataProvider.cacheData(key: 'CACHED_Story', data: remoteData);
          //
          // return remoteData;
        },

        getCacheDataFunction: ()async {
          List<dynamic> reslet = await db.getAllstory('story');
          List<StoryModel> list=[] ;
          reslet.forEach((element) {
            StoryModel user = StoryModel.fromJson(element);
         list.add(user);
          });


          return  list;
        });
  }


//   Future<Either<List<StoryModel>, Failure>>getdatafromsqflite(){
//
//     StoryModel storyModel =StoryModel(cover_photo: null, author: null, level: null, required_stars: null, name: null);
//
//      if(networkInfo.isConnected ==true){
//        try {
//
//          return Right(storyModel);
//        } on CacheException {
//          return Left(CacheFailure());
//        }
//
//
//      }
// }
//




}