import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_google_maps/core/base_user_case/base_user_case.dart';
import 'package:task_google_maps/core/error/failure.dart';
import 'package:task_google_maps/task/domain/repositories/base_app_repository.dart';

import '../entities/user.dart';

class SignInUseCase extends BaseUseCase<Future<Either<Failure, User>> ,SignInParameter> {

  final BaseAppRepository baseAppRepository;

  SignInUseCase(this.baseAppRepository);
  @override
  Future<Either<Failure, User>> call(SignInParameter parameters) async {
   return await baseAppRepository.signInUser(parameters);
  }

}

class SignInParameter extends Equatable {
  final String userPhone;
  final String password;
  final String firebaseToken;

  const SignInParameter({
    required this.userPhone,
    required this.password,
    required this.firebaseToken,
  });

  @override
  List<Object> get props => [userPhone, password, firebaseToken];
}
