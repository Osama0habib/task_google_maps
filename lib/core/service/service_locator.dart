
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:task_google_maps/task/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:task_google_maps/task/data/repositories/app_repository.dart';
import 'package:task_google_maps/task/domain/repositories/base_app_repository.dart';
import 'package:task_google_maps/task/domain/use_cases/get_api_marker_usecase.dart';
import 'package:task_google_maps/task/domain/use_cases/get_location_stream_usecase.dart';
import 'package:task_google_maps/task/domain/use_cases/get_stream_markers_usecase.dart';
import 'package:task_google_maps/task/domain/use_cases/signIn_usercase.dart';
import 'package:task_google_maps/task/domain/use_cases/update_firebase_location_usecase.dart';
import 'package:task_google_maps/task/presentation/manager/authBloc/auth_bloc.dart';
import 'package:task_google_maps/task/presentation/manager/location_bloc/location_bloc.dart';
import 'package:task_google_maps/task/presentation/manager/mapBloc/map_bloc.dart';


final sl = GetIt.instance;
class ServiceLocator {
  void init(){
    /// Bloc
    sl.registerFactory(() => AuthBloc(sl()));
    sl.registerFactory(() => MapBloc(sl(),sl(),sl(),sl()));
    sl.registerFactory(() => LocationBloc(sl()));


    /// Remote DataSource
    sl.registerLazySingleton<BaseRemoteDataSource>(() => RemoteDataSource());

    /// App Repository
    sl.registerLazySingleton<BaseAppRepository>(() => AppRepository(sl()));

    /// Usecases
    sl.registerLazySingleton(() => SignInUseCase(sl()));
    sl.registerLazySingleton(() => GetApiMarkersUseCase(sl()));
    sl.registerLazySingleton(() => GetStreamMarkersUseCase(sl()));
    sl.registerLazySingleton(() => UpdateFirebaseLocationUseCase(sl()));
    sl.registerLazySingleton(() => GetLocationStreamUseCase(sl()));


    /// geoLocation
    sl.registerLazySingleton(() => Geolocator());


  }
}