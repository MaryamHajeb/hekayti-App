import 'dart:developer';

import 'package:hikayati_app/dataProviders/local_data_provider.dart';
import 'package:hikayati_app/dataProviders/network/Network_info.dart';
import 'package:hikayati_app/dataProviders/network/data_source_url.dart';
import 'package:hikayati_app/dataProviders/remote_data_provider.dart';
import 'package:hikayati_app/dataProviders/repository.dart';
import 'package:dartz/dartz.dart';


import '../../../../core/util/common.dart';
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


  Future<Either<Failure, dynamic>> getAllStory() async {
    return await sendRequest(

        checkConnection: networkInfo.isConnected,

        remoteFunction: () async {


          List<StoryModel>list =[];
          List<dynamic> reslet = await db.getAllstory('story','1');

          int? start=0;
          int collected_stars =0;
          int all_stars =0;
          reslet.forEach((element) async{
            start  =await db.getStoryStars('1',element['id']);
            all_stars+=start!;

            collected_stars+= int.parse(element['required_star'].toString());



            list.add(
              
                StoryModel(
                    cover_photo: element['coverphoto'],
                    auther: element['auther'],
                    level: element['level'],
                    required_star: element['required_star'],
                    name: element['name'],
                    stars: start.toString(),
                    id: element['id'])
            );
            start=0;
          });
          CachedDate('stars',start);
          CachedDate('collected_stars',collected_stars);

          return  list;
          // localDataProvider.cacheData(key: 'CACHED_Story', data: remoteData);
          //
          // return remoteData;
        },




        getCacheDataFunction: ()async {
          List<StoryModel>list =[];
          List<dynamic> reslet = await db.getAllstory('story','1');

          int? start=0;
          int collected_stars =0;
          reslet.forEach((element) async{
          start  =await db.getStoryStars('1',element['id']);


          collected_stars+= int.parse(element['required_star'].toString());





            list.add(
                StoryModel(
                    cover_photo: element['coverphoto'],
                    auther: element['auther'],
                    level: element['level'],
                    required_star: element['required_star'],
                    name: element['name'],
                    stars: start.toString(),
                    id: element['id'])
            );
            start=0;
          });

          CachedDate('stars',start);
          CachedDate('collected_stars',collected_stars);



          return  list;
        });
  }





}