import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvents,LoginState>{
  LoginBloc():super(LoginState()){
    on<EmailChangedEvent>(_onEmailChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
    on<LoginApiEvent>(_loginApi);
  }

  void _onEmailChanged(EmailChangedEvent event,Emitter<LoginState>emit)
  {
    emit(state.copyWith(
      email:event.email
    ));
  }

  void _onPasswordChanged(PasswordChangedEvent event,Emitter<LoginState>emit)
  {
    emit(state.copyWith(
        email:event.password
    ));
  }
  void _loginApi(LoginApiEvent event,Emitter<LoginState> emit)async{
    emit(state.copyWith(
      loginStatus: LoginStatus.loading
    ));
    Map data={'email':state.email,'password':state.password,};
    try{
       final response=await http.post(Uri.parse("https://retoolapi.dev/twcHOZ/login"),body: data);
       if(response.statusCode==200) {
         emit(
             state.copyWith(
                 loginStatus: LoginStatus.success,
                 massage:"Login Successful"
             )
         );
       }
       else{
         emit(
             state.copyWith(
               loginStatus: LoginStatus.error,
                 massage:"Something went wrong try again"
             )
         );
       }

    }
    catch(e){
      print(e);
        emit(
          state.copyWith(
              loginStatus: LoginStatus.error,
            massage: e.toString()
          )
        );
    }
  }

}