import 'dart:developer';

import 'package:hikayati_app/dataProviders/local_data_provider.dart';
import 'package:hikayati_app/dataProviders/network/Network_info.dart';
import 'package:hikayati_app/dataProviders/network/data_source_url.dart';
import 'package:hikayati_app/dataProviders/remote_data_provider.dart';
import 'package:hikayati_app/dataProviders/repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../dataProviders/error/failures.dart';
import '../model/UsersMode.dart';


class LoginRepository extends Repository{
  final RemoteDataProvider remoteDataProvider; //get the data from the internet
  final LocalDataProvider localDataProvider; //get the data from the local cache
  final NetworkInfo networkInfo; //check if the device is connected to internet

  LoginRepository({
    required this.remoteDataProvider,
    required this.localDataProvider,
    required this.networkInfo,
  });


  Future<Either<Failure, dynamic>> Regstrtion() async {
    return await sendRequest(

        checkConnection: networkInfo.isConnected,

        remoteFunction: () async {
          final remoteData = await remoteDataProvider.sendData(
              url: DataSourceURL.getAllTechers,
              retrievedDataType: UsersModel.init(),
              returnType:List,
              body: {}
          );

          localDataProvider.cacheData(key: 'CACHED_CATEGORIES', data: remoteData);

          return remoteData;
        },

        getCacheDataFunction: () {
          return localDataProvider.getCachedData(
              key: 'CACHED_CATEGORIES',
              retrievedDataType: UsersModel.init(),
              returnType: List
          );
        });
  }








}