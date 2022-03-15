import 'package:flutter/material.dart';
import 'package:login_assignment/domain/entities/login_entity.dart';

class HomeScreen extends StatelessWidget {
  final LoginEntity loginEntity;

  const HomeScreen({Key? key, required this.loginEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Authorised: ${loginEntity.authorised}"),
            Text("Registered: ${loginEntity.registered}"),
          ],
        ),
      ),
    );
  }
}
