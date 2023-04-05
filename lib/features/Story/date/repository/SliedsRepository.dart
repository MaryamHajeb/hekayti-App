import 'dart:developer';

import 'package:hikayati_app/dataProviders/local_data_provider.dart';
import 'package:hikayati_app/dataProviders/network/Network_info.dart';
import 'package:hikayati_app/dataProviders/network/data_source_url.dart';
import 'package:hikayati_app/dataProviders/remote_data_provider.dart';
import 'package:hikayati_app/dataProviders/repository.dart';
import 'package:dartz/dartz.dart';


import '../../../../dataProviders/error/failures.dart';
import '../../../../dataProviders/network/data_source_url.dart';
import '../model/StoryMode.dart';


class SliedRepository extends Repository{
  final RemoteDataProvider remoteDataProvider; //get the data from the internet
  final LocalDataProvider localDataProvider; //get the data from the local cache
  final NetworkInfo networkInfo; //check if the device is connected to internet


  SliedRepository({

    required this.remoteDataProvider,
    required this.localDataProvider,
    required this.networkInfo,
  });


  Future<Either<Failure, dynamic>> getAllCategoriesSlied({required String category_id,token}) async {
    return await sendRequest(

        checkConnection: networkInfo.isConnected,

        remoteFunction: () async {
          final remoteData = await remoteDataProvider.sendData(
              url: DataSourceURL.getAllSlied,
              retrievedDataType: StoryModel.init(),
              returnType:List,
              body: {
                'category_id':category_id,
                'api_token':token
              }
          );

          localDataProvider.cacheData(key: 'CACHED_Slied', data: remoteData);

          return remoteData;
        },

        getCacheDataFunction: () {
          return localDataProvider.getCachedData(
              key: 'CACHED_Slied',
              retrievedDataType: StoryModel.init(),
              returnType: List
          );
        }



    );



  }








}