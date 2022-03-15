import '../core/api_client.dart';
import '../core/wrong_otp_exception.dart';
import '../models/login_model.dart';

abstract class RemoteDataSource {
  Future<bool> sendOTP(String phone);

  Future<LoginModel> verifyOTP(String phone, String otp);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final ApiClient _client;

  RemoteDataSourceImpl(this._client);

  @override
  Future<bool> sendOTP(String phone) async {
    try {
      await _client.get("/user/otp_login", params: {"phone": phone});
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginModel> verifyOTP(String phone, String otp) async {
    try {
      final res = await _client.post("/user/otp_login",
          params: {"otp": otp}, urlParams: {"phone": phone});
      return LoginModel.fromJson(res);
    } catch (e) {
      if (e.toString().compareTo("Exception: OTP is wrong/expired") == 0) {
        throw WrongOTPException();
      }
      rethrow;
    }
  }
}
