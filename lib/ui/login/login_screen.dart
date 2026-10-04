import 'package:bloc_counter_app/bloc/login_bloc/login_bloc.dart';
import 'package:bloc_counter_app/bloc/login_bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late LoginBloc _loginBloc;
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: BlocProvider(create: (_) => _loginBloc,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<LoginBloc ,LoginState>(
                  buildWhen: (current,previous)=> current.email != previous.email,
                  builder: (context, state) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      focusNode: emailFocusNode,
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        context.read<LoginBloc>().add(EmailChangedEvent(email: value));
                      },
                      onFieldSubmitted: (value) {},
                    );
                  },
                ),
                SizedBox(height: 20,),
                BlocBuilder<LoginBloc ,LoginState>(
                  buildWhen: (current,previous)=> current.password != previous.password,
                  builder: (context, state) {
                    return  TextFormField(
                      keyboardType: TextInputType.text,
                      focusNode: passwordFocusNode,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        context.read<LoginBloc>().add(PasswordChangedEvent(password:value));
                      },
                      onFieldSubmitted: (value) {},
                    );
                  },
                ),

                SizedBox(height: 20,),
                BlocListener<LoginBloc,LoginState>(
                  listener:(context, state) {
                     if(state.loginStatus==LoginStatus.error)
                       {
                         ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                           SnackBar(content: Text(state.massage.toString()))
                         );
                       }
                     if(state.loginStatus==LoginStatus.loading)
                     {
                       ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                           SnackBar(content:Text("Submitting....."))
                       );
                     }
                     if(state.loginStatus==LoginStatus.success)
                     {
                       ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                           SnackBar(content: Text("Login Successful"))
                       );
                     }
                  },
                  child:BlocBuilder<LoginBloc ,LoginState>(
                    buildWhen: (current,previous)=>false,
                    builder: (context, state) {
                      return  ElevatedButton(onPressed: () {
                        context.read<LoginBloc>().add(LoginApiEvent());
                      }, child: Text("Submit"));
                    },
                  ),
                )


              ],
            ),
          ),
        )
    );
  }
}
