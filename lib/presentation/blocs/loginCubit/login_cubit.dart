import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_assignment/domain/entities/app_error.dart';
import 'package:login_assignment/domain/entities/login_entity.dart';
import 'package:login_assignment/domain/usecases/send_otp.dart';
import 'package:login_assignment/domain/usecases/verify_otp.dart';

import '../../../domain/entities/send_otp_params.dart';
import '../../../domain/entities/verify_otp_params.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SendOTP _sendOTP;
  final VerifyOTP _verifyOTP;

  LoginCubit(this._sendOTP, this._verifyOTP) : super(LoginInitial());

  sendOtp(String phone) async {
    emit(LoginLoading());
    final result = await _sendOTP(SendOTPParams(phone));
    result.fold(
        (l) => emit(LoginFailed(l.appErrorType)), (r) => emit(OTPSent()));
  }

  verifyOtp(String phone, String otp) async {
    emit(LoginLoading());
    final result = await _verifyOTP(VerifyOTPParams(phone, otp));
    result.fold((l) {
      if (l.appErrorType == AppErrorType.wrongOTP) {
        emit(InvalidOTP());
      } else {
        emit(LoginFailed(l.appErrorType));
      }
    }, (r) => emit(OTPVerified(r)));
  }
}
