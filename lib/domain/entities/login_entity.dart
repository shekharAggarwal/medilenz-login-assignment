import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final bool authorised;
  final bool registered;

  const LoginEntity(this.authorised, this.registered);

  @override
  List<Object?> get props => [authorised, registered];
}
