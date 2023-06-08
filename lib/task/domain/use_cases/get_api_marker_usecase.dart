import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_google_maps/core/base_user_case/base_user_case.dart';
import 'package:task_google_maps/core/error/failure.dart';
import 'package:task_google_maps/task/domain/entities/marker.dart';

import '../repositories/base_app_repository.dart';

class GetApiMarkersUseCase extends BaseUseCase<Future<Either<Failure, List<MarkerEntity>>>,GetApiMarkersParameter> {

  final BaseAppRepository baseAppRepository;

  GetApiMarkersUseCase(this.baseAppRepository);
  @override
  Future<Either<Failure, List<MarkerEntity>>> call(GetApiMarkersParameter parameters) async {
    return await baseAppRepository.getApiMarkers(parameters);
  }

}

class GetApiMarkersParameter extends Equatable {
  final String token;


  const GetApiMarkersParameter({
    required this.token,

  });

  @override
  List<Object> get props => [token,];
}