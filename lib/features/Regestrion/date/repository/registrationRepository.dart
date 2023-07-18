import 'dart:developer';
import 'package:hikayati_app/dataProviders/local_data_provider.dart';
import 'package:hikayati_app/dataProviders/network/Network_info.dart';
import 'package:hikayati_app/dataProviders/network/data_source_url.dart';
import 'package:hikayati_app/dataProviders/remote_data_provider.dart';
import 'package:hikayati_app/dataProviders/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hikayati_app/features/Story/date/model/accuracyModel.dart';

import '../../../../core/util/common.dart';
import '../../../../core/util/database_helper.dart';
import '../../../../core/util/Encrypt.dart';
import '../../../../dataProviders/error/failures.dart';
import '../model/CompletionModel.dart';
import '../model/userMode.dart';

class RegistrationRepository extends Repository {
  final RemoteDataProvider remoteDataProvider; //get the data from the internet
  final LocalDataProvider localDataProvider; //get the data from the local cache
  final NetworkInfo networkInfo; //check if the device is connected to internet

  DatabaseHelper db = new DatabaseHelper();


  RegistrationRepository({
    required this.remoteDataProvider,
    required this.localDataProvider,
    required this.networkInfo,
  });
  late  UserModel userModel;
  late List<CompletionModel> completionModel;
  late List<accuracyModel>  AccuracyModel;
  Future<Either<Failure, dynamic>> signup(
      {required String  password, email}) async {
    userModel = getCachedDate('UserInformation', UserModel.init());
    return await sendRequest(
        checkConnection: networkInfo.isConnected,
        remoteFunction: () async {
          final remoteData = await remoteDataProvider.sendData(
              url: DataSourceURL.signup,
              retrievedDataType: int,
              returnType: int,
              body: {
                'password':Encryption.instance.encrypt(password) ,
                'email': email,
                'character': userModel!.character.toString(),
                'level': userModel.level.toString(),
                'user_name': userModel.user_name,

              });

          localDataProvider.cacheData(key: 'UserInformation', data: UserModel(user_name:userModel.user_name, email: email, level: userModel.level, character: userModel.character, update_at:  DateTime.now().toString(), password: Encryption.instance.encrypt(password), id: remoteData.toString()));
           print(remoteData);
         // await   db.initApp(userModel.level.toString(), '1');
          await  db.uploadAccuracy(remoteData);
          await    db.uploadCompletion(remoteData);
          await Future.delayed(Duration(seconds: 1));

          return remoteData;
        });
  }

  Future<Either<Failure, dynamic>> login(
      {required String password,required String email}) async {



    return await sendRequest(
        checkConnection: networkInfo.isConnected,
        remoteFunction: () async {
          final remoteData = await remoteDataProvider.sendData(
              url: DataSourceURL.login,
              retrievedDataType: UserModel.init(),
              body: {
                'password': Encryption.instance.encrypt(password).toString(),
                'email': email,
              });




          userModel = remoteData;

          await   db.initApp(userModel.level.toString(), '1');

          localDataProvider.cacheData(key: 'UserInformation', data: userModel);

          List<accuracyModel> accuracyModeldata = await remoteDataProvider.sendData(
              url: DataSourceURL.getAllaccuracy,
              retrievedDataType: accuracyModel.init(),
              returnType:List,
              body: {
                'user_id':userModel.id.toString()
              });

          db.checkAccuracyFound(accuracyModeldata);

          List<CompletionModel> completionData = await remoteDataProvider.sendData(
              url: DataSourceURL.getAllcompletion,
              retrievedDataType: CompletionModel.init(),
              returnType:List,

              body: {
                'user_id':userModel.id.toString()
              });
         // completionModel=completionData;


          db.checkCompletionFound(completionData);
          await Future.delayed(Duration(seconds: 1));

          return remoteData;
        });
   // db.checkAccuracyFound(data);
    //
    //
  }
}
