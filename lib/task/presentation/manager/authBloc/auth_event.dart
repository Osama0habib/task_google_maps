part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();


}

class InitializeAuthEvent extends AuthEvent {
  const InitializeAuthEvent();

  @override
  List<Object> get props => [];

}

class SignInEvent extends AuthEvent {
  final String userPhone;
  final String password;
  final String firebaseToken;

  const SignInEvent(
      {required this.userPhone, required this.password, required this.firebaseToken});

  @override
  List<Object> get props => [userPhone, password, firebaseToken];
}
