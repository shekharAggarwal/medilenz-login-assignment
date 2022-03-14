import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:login_assignment/domain/repositories/remote_repository.dart';
import 'package:login_assignment/domain/usecases/send_otp.dart';
import 'package:login_assignment/domain/usecases/verify_otp.dart';

import '../data/core/api_client.dart';
import '../data/dataSources/remote_data_source.dart';
import '../data/repositories/remote_repository_impl.dart';
import '../presentation/blocs/loginCubit/login_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));
  //Datasource
  getItInstance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<RemoteRepository>(
      () => RemoteRepositoryImpl(getItInstance()));

  //useCase
  getItInstance.registerLazySingleton<SendOTP>(() => SendOTP(getItInstance()));

  getItInstance
      .registerLazySingleton<VerifyOTP>(() => VerifyOTP(getItInstance()));

  //cubit
  getItInstance.registerFactory<LoginCubit>(
      () => LoginCubit(getItInstance(), getItInstance()));
}
