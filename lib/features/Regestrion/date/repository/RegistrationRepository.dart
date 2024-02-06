import 'package:hikayati_app/dataProviders/local_data_provider.dart';
import 'package:hikayati_app/dataProviders/network/Network_info.dart';
import 'package:hikayati_app/dataProviders/network/data_source_url.dart';
import 'package:hikayati_app/dataProviders/remote_data_provider.dart';
import 'package:hikayati_app/dataProviders/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hikayati_app/features/Story/date/model/accuracyModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/util/common.dart';
import '../../../../core/util/Encrypt.dart';
import '../../../../dataProviders/error/failures.dart';
import '../../../../main.dart';
import '../model/CompletionModel.dart';
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
  UserModel? userModel;
  SharedPreferences? prefs;
  bool islogin = false;
  late List<CompletionModel> completionModel;
  late List<accuracyModel> AccuracyModel;
  Future<Either<Failure, dynamic>> signup(
      {required String password, email}) async {
    userModel = await getCachedData(
      key: 'UserInformation',
      retrievedDataType: UserModel.init(),
      returnType: UserModel.init(),
    );
    final prefs = await SharedPreferences.getInstance();
    islogin = await prefs.getBool('onbording') ?? false;

    return await sendRequest(
        checkConnection: networkInfo.isConnected,
        remoteFunction: () async {
          final remoteData = await remoteDataProvider.sendData(
              url: DataSourceURL.signup,
              retrievedDataType: int,
              returnType: int,
              body: {
                'password': Encryption.instance.encrypt(password),
                'email': email,
                'character': userModel?.character ?? "0",
                'level': userModel?.level ?? "0",
                'user_name': userModel?.user_name ?? "M",
                'api_key': "zaCELgL.0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx"
              });
          print(remoteData);

          localDataProvider.cacheData(
              key: 'UserInformation',
              data: UserModel(
                  user_name: userModel?.user_name,
                  email: email,
                  level: userModel?.level,
                  character: userModel?.character,
                  update_at: DateTime.now().toString(),
                  password: Encryption.instance.encrypt(password),
                  id: remoteData.toString()));

          await db.uploadAccuracy(remoteData);
          await db.uploadCompletion(remoteData);
          await Future.delayed(Duration(seconds: 5));

          return remoteData;
        });
  }

  Future<Either<Failure, dynamic>> login(
      {required String password, required String email}) async {
    var prefs = await SharedPreferences.getInstance();

    return await sendRequest(
        checkConnection: networkInfo.isConnected,
        remoteFunction: () async {
          final remoteData = await remoteDataProvider.sendData(
              url: DataSourceURL.login,
              retrievedDataType: UserModel.init(),
              body: {
                'password': Encryption.instance.encrypt(password).toString(),
                'email': email,
                'api_key': "zaCELgL.0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx"
              });

          userModel = remoteData;

          await db.LoadingApp(userModel!.level.toString(), '1');

          localDataProvider.cacheData(key: 'UserInformation', data: userModel);
          db.deleteTable('completion');
          db.deleteTable('accuracy');
          List<accuracyModel> accuracyModeldata = await remoteDataProvider
              .sendData(
                  url: DataSourceURL.getAllaccuracy,
                  retrievedDataType: accuracyModel.init(),
                  returnType: List,
                  body: {'user_id': userModel!.id.toString()});

          db.checkAccuracyFound(accuracyModeldata);

          List<CompletionModel> completionData = await remoteDataProvider
              .sendData(
                  url: DataSourceURL.getAllcompletion,
                  retrievedDataType: CompletionModel.init(),
                  returnType: List,
                  body: {'user_id': userModel!.id.toString()});
          // completionModel=completionData;

          db.checkCompletionFound(completionData);

          prefs.setBool('onbording', true);

          return remoteData;
        });
    // db.checkAccuracyFound(data);
    //
    //
  }
}
