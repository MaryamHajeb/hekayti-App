import 'dart:developer';

import 'package:hikayati_app/dataProviders/local_data_provider.dart';
import 'package:hikayati_app/dataProviders/network/Network_info.dart';
import 'package:hikayati_app/dataProviders/network/data_source_url.dart';
import 'package:hikayati_app/dataProviders/remote_data_provider.dart';
import 'package:hikayati_app/dataProviders/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hikayati_app/features/Story/date/model/StoryMediaModel.dart';


import '../../../../core/util/common.dart';
import '../../../../core/util/database_helper.dart';
import '../../../../dataProviders/error/failures.dart';
import '../../../../dataProviders/network/data_source_url.dart';
import '../../../Home/data/model/StoryMode.dart';


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
    return  sendRequest(

        checkConnection: networkInfo.isConnected,

        remoteFunction: () async {





          return  await getStars();


        },

        getCacheDataFunction: () async{

          return  await getStars();
        }



    );



  }






 Future<List<StoryModel>> getStars()async{

   List<dynamic> reslet = await db.getAllstory('stories','1');
    List<StoryModel> dd=[];
    int collected_stars =0;
    int all_stars =reslet.length *3;

    reslet.forEach((element) async{
      String? start='';
      start  =await db.getStoryStars('1',element['id']);
      if(start=='')
      {
        start='0';
      }

      collected_stars+=int.parse(start);





      dd.add(

          StoryModel(
            download: true,
              cover_photo: element['cover_photo'],
              author: element['author'],
              level: element['level'],
              required_stars: element['required_stars'],
              name: element['name'],
              stars: start.toString(),
              id: element['id'],
              story_order:element['story_order'],
              updated_at: element['updated_at'] )
      );
//      start='';

    });
   await Future.delayed(Duration(seconds: 1));
 print(collected_stars);
 print(all_stars);
 print('all_stars');
    CachedDate('all_stars',all_stars);
    CachedDate('collected_stars',collected_stars);
    return  dd;
  }

}