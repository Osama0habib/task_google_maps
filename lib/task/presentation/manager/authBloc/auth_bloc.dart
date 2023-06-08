import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_google_maps/core/constants/app_constant.dart';
import 'package:task_google_maps/task/domain/use_cases/signIn_usercase.dart';

import '../../../../core/utils/enums.dart';
import '../../../domain/entities/user.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController(text: "+201159050444");
  final TextEditingController passwordController = TextEditingController(text: "12345678");



  @override
  Future<Function> close()async {
    super.close();
    phoneController.dispose();
    passwordController.dispose();
    return await close();
  }

  AuthBloc(this.signInUseCase) : super(const AuthState()) {
    on<InitializeAuthEvent>(_initializeAuth);
    on<SignInEvent>(_signIn);
  }

  Future<FutureOr<void>> _signIn(
      SignInEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await signInUseCase(SignInParameter(
      userPhone: event.userPhone,
      password: event.password,
      firebaseToken: event.firebaseToken,
    ));
    result.fold(
      (l) => emit(
        state.copyWith(requestState: RequestState.error, errorMsg: l.message),
      ),
      (r) {
        user = r;
        emit(
          state.copyWith(requestState: RequestState.loaded, user: user),
        );
      },
    );
  }

  FutureOr<void> _initializeAuth(
    InitializeAuthEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(formKey: formKey, phoneController: phoneController, passwordController: passwordController,initializeState: RequestState.loaded));
  }
}
