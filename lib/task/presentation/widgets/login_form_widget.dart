import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_google_maps/core/constants/app_constant.dart';
import 'package:task_google_maps/task/presentation/manager/authBloc/auth_bloc.dart';
import 'package:task_google_maps/task/presentation/widgets/custom_text_field.dart';

import '../../../core/service/service_locator.dart';
import '../../../core/utils/enums.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({Key? key, required this.state}) : super(key: key);
  final AuthState state;
  @override
  Widget build(BuildContext context) {

    switch (state.initializeState){
            case RequestState.idle:
              return const Center(child: CircularProgressIndicator(),);
            case RequestState.loading:
              return const Center(child: CircularProgressIndicator(),);
            case RequestState.loaded:
              return Form(
                  key: state.formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                          hintText: "Phone Number",
                          suffixIcon: const Icon(Icons.phone),
                          controller: state.phoneController!),
                      CustomTextField(
                          hintText: "Password",
                          suffixIcon: const Icon(Icons.visibility),
                          controller: state.passwordController!),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forget your password ?",
                            )),
                      ),
                      FilledButton(onPressed: () {
                        if(state.formKey!.currentState!.validate()){
                          context.read<AuthBloc>().add(SignInEvent(userPhone: state.phoneController!.text, password: state.passwordController!.text, firebaseToken: ""));
                        }
                      }, child: const Text("Log in"))
                    ],
                  ));
            case RequestState.error:
              return const Center(child: Text("Error Loading Page"),);
          }

  }
}
