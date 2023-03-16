import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'error/exceptions.dart';
import 'error/failures.dart';

typedef Future<dynamic> GetDataFunction();
typedef dynamic GetCacheDataFunction();

class Repository {
  Future<Either<Failure, dynamic>> sendRequest({

    GetDataFunction? remoteFunction,
    GetCacheDataFunction? getCacheDataFunction,
    required Future<bool> checkConnection,
  }) async {
    log('send request running');


    if (await checkConnection) {
      log('check connection ');
      try {
        log('try from repositories');

        final remoteData = await remoteFunction!();
        log('the data from repositories is $remoteData');
        return Right(remoteData);


      } on ServierExeption {
        return Left(ServerFailure());
      } on NotFound {
        return Left(NotFounFailure());
      } on BlockedUser {
        return Left(BlockedUserFailure());
      }
    }
    else {
      if (getCacheDataFunction == null) {
        return Left(ConnectionFailure());
      }

      try {
        final localData = getCacheDataFunction();
        return Right(localData);
      } on CacheException {
        return Left(CacheFailure());
      } on EmptyException {
        return Left(NotFoundFailure());
      } catch (Exception) {
        print(Exception);
        return Left(ConnectionFailure());
      }
    }
  }
}
