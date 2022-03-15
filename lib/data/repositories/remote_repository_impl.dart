import 'package:dartz/dartz.dart';
import 'package:login_assignment/data/core/wrong_otp_exception.dart';
import 'package:login_assignment/data/dataSources/remote_data_source.dart';
import 'package:login_assignment/domain/entities/app_error.dart';
import 'package:login_assignment/domain/repositories/remote_repository.dart';

import '../../domain/entities/login_entity.dart';

class RemoteRepositoryImpl extends RemoteRepository {
  final RemoteDataSource _remoteDataSource;

  RemoteRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<AppError, bool>> sendOTP(String phone) async {
    try {
      final res = await _remoteDataSource.sendOTP(phone);
      return Right(res);
    } catch (e) {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, LoginEntity>> verifyOTP(
      String phone, String otp) async {
    try {
      final res = await _remoteDataSource.verifyOTP(phone, otp);
      return Right(res);
    } on WrongOTPException {
      return const Left(AppError(AppErrorType.wrongOTP));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
