import 'dart:developer';

import 'package:hikayati_app/dataProviders/local_data_provider.dart';
import 'package:hikayati_app/dataProviders/network/Network_info.dart';
import 'package:hikayati_app/dataProviders/network/data_source_url.dart';
import 'package:hikayati_app/dataProviders/remote_data_provider.dart';
import 'package:hikayati_app/dataProviders/repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../dataProviders/error/failures.dart';
import '../model/TechersMode.dart';


class TechersRepository extends Repository{
  final RemoteDataProvider remoteDataProvider; //get the data from the internet
  final LocalDataProvider localDataProvider; //get the data from the local cache
  final NetworkInfo networkInfo; //check if the device is connected to internet

  TechersRepository({
    required this.remoteDataProvider,
    required this.localDataProvider,
    required this.networkInfo,
  });


  Future<Either<Failure, dynamic>> getAllTechers() async {
    return await sendRequest(

        checkConnection: networkInfo.isConnected,

        remoteFunction: () async {
          final remoteData = await remoteDataProvider.sendData(
              url: DataSourceURL.getAllTechers,
              retrievedDataType: TechersModel.init(),
              returnType:List,
              body: {}
          );

          localDataProvider.cacheData(key: 'CACHED_Techers', data: remoteData);

          return remoteData;
        },

        getCacheDataFunction: () {
          return localDataProvider.getCachedData(
              key: 'CACHED_Techers',
              retrievedDataType: TechersModel.init(),
              returnType: List
          );
        });
  }








}