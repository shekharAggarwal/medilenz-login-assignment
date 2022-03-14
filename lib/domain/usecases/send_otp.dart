import 'package:dartz/dartz.dart';
import 'package:login_assignment/domain/entities/app_error.dart';
import 'package:login_assignment/domain/entities/send_otp_params.dart';
import 'package:login_assignment/domain/repositories/remote_repository.dart';

import 'usecase.dart';

class SendOTP extends UseCase<bool, SendOTPParams> {
  final RemoteRepository remoteRepository;

  SendOTP(this.remoteRepository);

  @override
  Future<Either<AppError, bool>> call(SendOTPParams params) {
    return remoteRepository.sendOTP(params.phone);
  }
}
