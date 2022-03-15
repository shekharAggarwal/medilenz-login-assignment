import 'package:dartz/dartz.dart';
import 'package:login_assignment/domain/entities/app_error.dart';
import 'package:login_assignment/domain/entities/login_entity.dart';

abstract class RemoteRepository {
  Future<Either<AppError, bool>> sendOTP(String phone);

  Future<Either<AppError, LoginEntity>> verifyOTP(String phone, String otp);
}
