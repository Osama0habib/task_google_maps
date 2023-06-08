import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:task_google_maps/core/base_user_case/base_user_case.dart';
import 'package:task_google_maps/core/error/failure.dart';
import 'package:task_google_maps/task/domain/repositories/base_app_repository.dart';

import '../entities/user.dart';

class UpdateFirebaseLocationUseCase extends BaseUseCase<Future<Either<Failure, void>>,UpdateFirebaseLocationParameter> {

  final BaseAppRepository baseAppRepository;

  UpdateFirebaseLocationUseCase(this.baseAppRepository);
  @override
  Future<Either<Failure, void>> call(UpdateFirebaseLocationParameter parameters) async {
    return await baseAppRepository.updateFirebaseLocation(parameters);
  }

}

class UpdateFirebaseLocationParameter extends Equatable {
  final String userId;
  final Position position;


  const UpdateFirebaseLocationParameter({
    required this.userId,
    required this.position,
  });

  @override
  List<Object> get props => [userId,position];
}
