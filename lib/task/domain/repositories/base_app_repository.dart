import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:task_google_maps/core/base_user_case/base_user_case.dart';
import 'package:task_google_maps/task/domain/entities/marker.dart';
import 'package:task_google_maps/task/domain/use_cases/get_api_marker_usecase.dart';
import 'package:task_google_maps/task/domain/use_cases/get_location_stream_usecase.dart';
import 'package:task_google_maps/task/domain/use_cases/signIn_usercase.dart';

import '../../../core/error/failure.dart';
import '../entities/user.dart';
import '../use_cases/get_stream_markers_usecase.dart';
import '../use_cases/update_firebase_location_usecase.dart';

abstract class BaseAppRepository{

  Future<Either<Failure,User>> signInUser(SignInParameter parameter);
  Future<Either<Failure,List<MarkerEntity>>> getApiMarkers(GetApiMarkersParameter parameter);
  Future<Either<Failure,void>> updateFirebaseLocation(UpdateFirebaseLocationParameter parameter);
  Either<Failure,StreamSubscription<DatabaseEvent>> getStreamMarkers(GetStreamMarkersParameter parameter);
  Either<Failure,Stream<Position>> getLocationStream(GetLocationStreamParameter parameter);




}