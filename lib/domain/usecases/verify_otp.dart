import 'package:dartz/dartz.dart';
import 'package:login_assignment/domain/entities/app_error.dart';
import 'package:login_assignment/domain/entities/verify_otp_params.dart';
import 'package:login_assignment/domain/repositories/remote_repository.dart';

import 'usecase.dart';

class VerifyOTP extends UseCase<bool, VerifyOTPParams> {
  final RemoteRepository remoteRepository;

  VerifyOTP(this.remoteRepository);

  @override
  Future<Either<AppError, bool>> call(VerifyOTPParams params) {
    return remoteRepository.verifyOTP(params.phone, params.otp);
  }
}
