import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_google_maps/task/presentation/manager/authBloc/auth_bloc.dart';
import 'package:task_google_maps/task/presentation/pages/login_page.dart';

import '../../../core/constants/app_constant.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utils/enums.dart';
import 'home_page.dart';

class AuthStatusScreen extends StatelessWidget {
  const AuthStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => sl<AuthBloc>()..add(const InitializeAuthEvent()),
      child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {

          },
          builder: (context, state) {
            switch(state.user){
              case  null :{
                return LoginPage(state: state);
              }
              default : {
                return const HomePage();
              }
            }

          }
      ),
    );
  }
}
