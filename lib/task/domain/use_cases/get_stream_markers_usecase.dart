import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:task_google_maps/core/base_user_case/base_user_case.dart';
import 'package:task_google_maps/core/error/failure.dart';
import 'package:task_google_maps/task/domain/entities/marker.dart';

import '../repositories/base_app_repository.dart';

class GetStreamMarkersUseCase extends BaseUseCase<Either<Failure,StreamSubscription<DatabaseEvent>>,GetStreamMarkersParameter> {

  final BaseAppRepository baseAppRepository;

  GetStreamMarkersUseCase(this.baseAppRepository);
  @override
  Either<Failure,StreamSubscription<DatabaseEvent>> call(GetStreamMarkersParameter parameters)  {
    return baseAppRepository.getStreamMarkers(parameters);
  }

}

class GetStreamMarkersParameter extends Equatable {
  final String userId;


  const GetStreamMarkersParameter({
    required this.userId,

  });

  @override
  List<Object> get props => [userId,];
}