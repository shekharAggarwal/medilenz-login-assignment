import '../core/api_client.dart';

abstract class RemoteDataSource {
  Future<bool> sendOTP(String phone);

  Future<bool> verifyOTP(String phone, String otp);
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
  Future<bool> verifyOTP(String phone, String otp) async {
    try {
      await _client.post("/user/otp_login",
          params: {"otp": otp}, urlParams: {"phone": phone});
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
