import 'package:hikayati_app/dataProviders/local_data_provider.dart';
import 'package:hikayati_app/dataProviders/network/Network_info.dart';
import 'package:hikayati_app/dataProviders/remote_data_provider.dart';
import 'package:hikayati_app/dataProviders/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hikayati_app/features/Settings/date/model/ReportModel.dart';

import '../../../../core/util/DataBaseHelper.dart';
import '../../../../dataProviders/error/failures.dart';

class ReportRepository extends Repository {
  final RemoteDataProvider remoteDataProvider; //get the data from the internet
  final LocalDataProvider localDataProvider; //get the data from the local cache
  final NetworkInfo networkInfo; //check if the device is connected to internet
  DataBaseHelper db = new DataBaseHelper();

  ReportRepository({
    required this.remoteDataProvider,
    required this.localDataProvider,
    required this.networkInfo,
  });

  Future<Either<Failure, dynamic>> getAllReport() async {
    return await sendRequest(
        checkConnection: networkInfo.isConnected,
        remoteFunction: () async {
          List<dynamic> reslet = await db.getReport();
          List<ReportModel> list = [];
          reslet.forEach((element) {
            ReportModel story = ReportModel.fromJson(element);
            list.add(story);
          });

          return list;
        },
        getCacheDataFunction: () async {
          List<dynamic> reslet = await db.getReport();
          List<ReportModel> list = [];
          reslet.forEach((element) {
            ReportModel story = ReportModel.fromJson(element);
            list.add(story);
          });

          return list;
        });
  }
}
