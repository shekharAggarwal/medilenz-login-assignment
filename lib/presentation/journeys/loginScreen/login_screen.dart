import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_assignment/di/get_it.dart';
import 'package:login_assignment/presentation/blocs/loginCubit/login_cubit.dart';
import 'package:login_assignment/presentation/journeys/otpScreen/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  late LoginCubit _loginCubit;

  @override
  void initState() {
    _loginCubit = getItInstance<LoginCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _loginCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => _loginCubit,
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is OTPSent) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => OTPScreen(
                              phone: _controller.text,
                            )));
              });
            }
            if (state is LoginFailed) {}
            if (state is LoginLoading) {}
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 15.0),
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: const InputDecoration(hintText: "Phone Number"),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty &&
                        _controller.text.length == 10) {
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Enter Phone Number")));
                    }
                  },
                  child: const Text("Login"),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
