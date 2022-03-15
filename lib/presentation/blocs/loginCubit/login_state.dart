part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class OTPSent extends LoginState {}

class InvalidOTP extends LoginState {}

class OTPVerified extends LoginState {
  final LoginEntity loginEntity;

  const OTPVerified(this.loginEntity);
}

class LoginFailed extends LoginState {
  final AppErrorType errorType;

  const LoginFailed(this.errorType);
}
