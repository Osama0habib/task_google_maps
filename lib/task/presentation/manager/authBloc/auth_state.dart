part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final TextEditingController? phoneController;
  final TextEditingController? passwordController;
  final GlobalKey<FormState>? formKey;
  final User? user;
  final RequestState initializeState;
  final RequestState requestState;
  final String errorMsg;

  const AuthState(
      {this.user,
      this.requestState = RequestState.idle,
      this.initializeState = RequestState.loading,
      this.errorMsg = "",
      this.formKey,
      this.phoneController,
      this.passwordController});

  AuthState copyWith({
    GlobalKey<FormState>? formKey,
    TextEditingController? phoneController,
    TextEditingController? passwordController,
    User? user,
    RequestState? requestState,
    RequestState? initializeState,
    String? errorMsg,
  }) =>
      AuthState(
        formKey: formKey ?? this.formKey,
        phoneController: phoneController ?? this.phoneController,
        passwordController: passwordController ?? this.passwordController,
        user: user ?? this.user,
        requestState: requestState ?? this.requestState,
        initializeState: initializeState ?? this.initializeState,
        errorMsg: errorMsg ?? this.errorMsg,
      );

  @override
  List<Object?> get props => [
        user,
        requestState,
        errorMsg,
        formKey,
        phoneController,
        passwordController,
        initializeState,
      ];
}
