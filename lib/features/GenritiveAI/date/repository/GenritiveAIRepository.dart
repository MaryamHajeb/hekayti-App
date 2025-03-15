import 'package:hikayati_app/dataProviders/local_data_provider.dart';
import 'package:hikayati_app/dataProviders/network/Network_info.dart';
import 'package:hikayati_app/dataProviders/network/data_source_url.dart';
import 'package:hikayati_app/dataProviders/remote_data_provider.dart';
import 'package:hikayati_app/dataProviders/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hikayati_app/features/Story/date/model/accuracyModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/util/Common.dart';
import '../../../../core/util/Encrypt.dart';
import '../../../../dataProviders/error/failures.dart';
import '../../../../main.dart';


class GenritiveAIRepository extends Repository {
  final RemoteDataProvider remoteDataProvider; //get the data from the internet
  final LocalDataProvider localDataProvider; //get the data from the local cache
  final NetworkInfo networkInfo; //check if the device is connected to internet

  GenritiveAIRepository({
    required this.remoteDataProvider,
    required this.localDataProvider,
    required this.networkInfo,
  });

  Future<Either<Failure, dynamic>> GenritiveAI(
      {required String password, email}) async
  {


    return await sendRequest(
        checkConnection: networkInfo.isConnected,
        remoteFunction: () async {
          final remoteData = await remoteDataProvider.sendData(
              url: DataSourceURL.signup,
              retrievedDataType: int,
              returnType: int,
              body: {
              }

              );




          return remoteData;
        });
  }


}
