import 'package:hikayati_app/dataProviders/local_data_provider.dart';
import 'package:hikayati_app/dataProviders/network/Network_info.dart';
import 'package:hikayati_app/dataProviders/remote_data_provider.dart';
import 'package:hikayati_app/dataProviders/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hikayati_app/features/Settings/date/model/ChartModel.dart';

import '../../../../core/util/database_helper.dart';
import '../../../../dataProviders/error/failures.dart';

class ChartRepository extends Repository {
  final RemoteDataProvider remoteDataProvider; //get the data from the internet
  final LocalDataProvider localDataProvider; //get the data from the local cache
  final NetworkInfo networkInfo; //check if the device is connected to internet
  DatabaseHelper db = new DatabaseHelper();

  ChartRepository({
    required this.remoteDataProvider,
    required this.localDataProvider,
    required this.networkInfo,
  });

  Future<Either<Failure, dynamic>> getAllChart({required String id}) async {
    return await sendRequest(
        checkConnection: networkInfo.isConnected,
        remoteFunction: () async {
          List<dynamic> reslet = await db.getAllReportChart(id);
          List<ChartModel> list = [];
          reslet.forEach((element) {
            print(element);
            print('element');
            ChartModel story = ChartModel.fromJson(element);
            list.add(story);
          });

          return list;
        },
        getCacheDataFunction: () async {
          List<dynamic> reslet = await db.getAllReportChart(id);

          List<ChartModel> list = [];
          reslet.forEach((element) {
            print(element);
            ChartModel story = ChartModel.fromJson(element);
            list.add(story);
          });

          return list;
        });
  }
}
