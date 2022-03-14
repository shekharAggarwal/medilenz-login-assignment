import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_assignment/domain/usecases/send_otp.dart';
import 'package:login_assignment/domain/usecases/verify_otp.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SendOTP sendOTP;
  final VerifyOTP verifyOTP;

  LoginCubit(this.sendOTP, this.verifyOTP) : super(LoginInitial());
}
