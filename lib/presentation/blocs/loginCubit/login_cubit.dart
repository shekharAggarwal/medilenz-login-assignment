import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_assignment/domain/entities/app_error.dart';
import 'package:login_assignment/domain/usecases/send_otp.dart';
import 'package:login_assignment/domain/usecases/verify_otp.dart';

import '../../../domain/entities/send_otp_params.dart';
import '../../../domain/entities/verify_otp_params.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SendOTP sendOTP;
  final VerifyOTP verifyOTP;

  LoginCubit(this.sendOTP, this.verifyOTP) : super(LoginInitial());

  sendOtp(String phone) async {
    emit(LoginLoading());
    final result = await sendOTP(SendOTPParams(phone));
    result.fold(
        (l) => emit(LoginFailed(l.appErrorType)), (r) => emit(OTPSent()));
  }

  verifyOtp(String phone, String otp) async {
    emit(LoginLoading());
    final result = await verifyOTP(VerifyOTPParams(phone, otp));
    result.fold(
        (l) => emit(LoginFailed(l.appErrorType)), (r) => emit(OTPVerified()));
  }
}
