import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dataProviders/local_data_provider.dart';
import 'dataProviders/network/Network_info.dart';
import 'dataProviders/remote_data_provider.dart';
import 'features/Regestrion/date/repository/registrationRepository.dart';
import 'features/Regestrion/presintation/manager/registration_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
final sl = GetIt.instance;


Future<void> init() async {
  print('start injection');

//  ! Features
//   _initRegisterFeature();


  _initRegistrationFeature();

  ///service provider

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //data providers

  // data sources
  sl.registerLazySingleton<RemoteDataProvider>(
      () => RemoteDataProvider(client: sl()));
  sl.registerLazySingleton<LocalDataProvider>(
      () => LocalDataProvider(sharedPreferences: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}


void _initRegistrationFeature() {
//bloc
  sl.registerFactory(() => RegistrationBloc(repository: sl()));

  //repositories
  sl.registerLazySingleton<RegistrationRepository>(
    () => RegistrationRepository(
      remoteDataProvider: sl(),
      localDataProvider: sl(),
      networkInfo: sl(),
    ),
  );
}
