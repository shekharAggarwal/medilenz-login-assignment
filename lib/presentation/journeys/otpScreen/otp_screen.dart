import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_assignment/presentation/journeys/homeScreen/home_screen.dart';
import 'package:password_input/inputText/password_input_text_field.dart';

class OTPScreen extends StatelessWidget {
  final String phone;

  const OTPScreen({Key? key, required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            child: PasswordInputTextField(
              passwordLength: 6,
              keyboardType: TextInputType.number,
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6)
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()));
              },
              child: const Text("Verify"))
        ],
      ),
    );
  }
}
