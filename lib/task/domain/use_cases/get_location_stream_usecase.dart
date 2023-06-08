import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/base_user_case/base_user_case.dart';
import '../../../core/error/failure.dart';
import '../repositories/base_app_repository.dart';

class GetLocationStreamUseCase extends BaseUseCase<Either<Failure, Stream<Position>>,GetLocationStreamParameter>{

  final BaseAppRepository baseAppRepository;

  GetLocationStreamUseCase(this.baseAppRepository);
  @override
  Either<Failure, Stream<Position>> call(GetLocationStreamParameter parameters) {
    return baseAppRepository.getLocationStream(parameters);
  }

}

class GetLocationStreamParameter extends Equatable {
  final LocationPermission permission;


  const GetLocationStreamParameter({
    required this.permission,

  });

  @override
  List<Object> get props => [permission,];
}