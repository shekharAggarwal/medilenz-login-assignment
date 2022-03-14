import 'package:dartz/dartz.dart';
import 'package:login_assignment/domain/entities/app_error.dart';

abstract class RemoteRepository {
  Future<Either<AppError, bool>> sendOTP(String phone);

  Future<Either<AppError, bool>> verifyOTP(String phone, String otp);
}
