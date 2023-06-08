import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:task_google_maps/core/base_user_case/base_user_case.dart';
import 'package:task_google_maps/core/error/failure.dart';
import 'package:task_google_maps/task/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:task_google_maps/task/domain/entities/marker.dart';
import 'package:task_google_maps/task/domain/entities/user.dart';
import 'package:task_google_maps/task/domain/repositories/base_app_repository.dart';
import 'package:task_google_maps/task/domain/use_cases/get_api_marker_usecase.dart';
import 'package:task_google_maps/task/domain/use_cases/get_location_stream_usecase.dart';
import 'package:task_google_maps/task/domain/use_cases/get_stream_markers_usecase.dart';
import 'package:task_google_maps/task/domain/use_cases/signIn_usercase.dart';
import 'package:task_google_maps/task/domain/use_cases/update_firebase_location_usecase.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/service/location_service.dart';

class AppRepository extends BaseAppRepository {
  final BaseRemoteDataSource baseRemoteDataSource;

  AppRepository(this.baseRemoteDataSource);

  @override
  Future<Either<Failure, List<MarkerEntity>>> getApiMarkers(GetApiMarkersParameter parameter) async{
    final result = await baseRemoteDataSource.getMarkers(token: parameter.token);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Either<Failure, StreamSubscription<DatabaseEvent>> getStreamMarkers(GetStreamMarkersParameter parameter) {
    final result =  baseRemoteDataSource.firebaseGetMarkers(userId: parameter.userId);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, User>> signInUser(SignInParameter parameter) async {
    final result = await baseRemoteDataSource.signIn(userPhone: parameter.userPhone,password: parameter.password,firebaseToken: parameter.firebaseToken);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, void>> updateFirebaseLocation(UpdateFirebaseLocationParameter parameter) async {
    final result = await baseRemoteDataSource.firebaseUpdateLocation(userId: parameter.userId, position: parameter.position);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Either<Failure, Stream<Position>> getLocationStream(GetLocationStreamParameter parameter)  {
    if(parameter.permission != LocationPermission.whileInUse || parameter.permission != LocationPermission.always){
      determinePosition();
    }
    final result =   Geolocator.getPositionStream(locationSettings: const LocationSettings(accuracy: LocationAccuracy.bestForNavigation,));
    try {
      return Right(result);
    } catch (failure) {
      return Left(ServerFailure(failure.toString()));
    }
  }


}