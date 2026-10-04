part of'login_bloc.dart';
enum LoginStatus{initial,loading,success,error}

class LoginState extends Equatable {
 final String massage;
 final String email;
 final String password;
 final LoginStatus loginStatus;


  const LoginState({
    this.massage='',
    this.email='',
    this.password='',
    this.loginStatus=LoginStatus.initial
  });

  LoginState copyWith({
    String? massage,
    String? email,
    String? password,
    LoginStatus? loginStatus
}){
    return LoginState(
      massage: massage??this.massage,
      email: email?? this.email,
      password: password?? this.password,
      loginStatus: loginStatus ?? this.loginStatus
    );
  }
  @override
  List<Object?> get props => [massage,email,password,loginStatus];
}

