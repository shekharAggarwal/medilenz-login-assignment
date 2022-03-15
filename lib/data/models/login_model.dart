import 'package:login_assignment/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  final bool authorised;
  final bool registered;

  const LoginModel({required this.authorised, required this.registered})
      : super(authorised, registered);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        authorised: json["Authorised"] ?? false,
        registered: json["Registered"] ?? false);
  }
}
