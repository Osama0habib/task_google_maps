import 'package:flutter/material.dart';
import 'package:task_google_maps/core/utils/enums.dart';
import 'package:task_google_maps/task/presentation/manager/authBloc/auth_bloc.dart';
import 'package:task_google_maps/task/presentation/widgets/login_form_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key,required this.state}) : super(key: key);
final AuthState state;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(appBar: AppBar(title: Text("Log In"), backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,foregroundColor: Colors.black,), body:Column(
              children: [
                Image.asset("assets/images/logo.png"),
                 LoginFormWidget(state: state,),
              ],

            ),),
        if(state.requestState == RequestState.loading)
          Container(color: Colors.black26,width: double.infinity,height: double.infinity,child: const Center(child: CircularProgressIndicator()),),
      ],
    );
  }
}
