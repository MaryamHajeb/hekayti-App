import 'dart:developer';

import 'package:hikayati_app/dataProviders/local_data_provider.dart';
import 'package:hikayati_app/dataProviders/network/Network_info.dart';
import 'package:hikayati_app/dataProviders/network/data_source_url.dart';
import 'package:hikayati_app/dataProviders/remote_data_provider.dart';
import 'package:hikayati_app/dataProviders/repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../dataProviders/error/failures.dart';
import '../model/userMode.dart';

class RegistrationRepository extends Repository {
  final RemoteDataProvider remoteDataProvider; //get the data from the internet
  final LocalDataProvider localDataProvider; //get the data from the local cache
  final NetworkInfo networkInfo; //check if the device is connected to internet

  RegistrationRepository({
    required this.remoteDataProvider,
    required this.localDataProvider,
    required this.networkInfo,
  });
  late  UserModel userModel;
  Future<Either<Failure, dynamic>> signup(
      {required String  password, email}) async {
    return await sendRequest(
        checkConnection: networkInfo.isConnected,
        remoteFunction: () async {
          final remoteData = await remoteDataProvider.sendData(
              url: DataSourceURL.signup,
              retrievedDataType: String,
              returnType: String,
              body: {
                'password': password,
                'email': email,
              });

          return remoteData;
        });
  }

  Future<Either<Failure, dynamic>> login(
      {required String password, email}) async {
    return await sendRequest(
        checkConnection: networkInfo.isConnected,
        remoteFunction: () async {
          final remoteData = await remoteDataProvider.sendData(
              url: DataSourceURL.login,
              retrievedDataType: UserModel.init(),
              body: {
                'password': password,
                'email': email,
              });
          userModel = remoteData;
          localDataProvider.cacheData(key: 'USER', data: userModel.toJson());

          return remoteData;
        });
  }
}
