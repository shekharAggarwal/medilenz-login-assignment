import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_assignment/di/get_it.dart';
import 'package:login_assignment/presentation/journeys/homeScreen/home_screen.dart';
import 'package:password_input/inputText/password_input_text_field.dart';

import '../../blocs/loginCubit/login_cubit.dart';

class OTPScreen extends StatefulWidget {
  final String phone;

  const OTPScreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late LoginCubit _loginCubit;

  @override
  initState() {
    _loginCubit = getItInstance<LoginCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _loginCubit.close();
    super.dispose();
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => _loginCubit,
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is OTPVerified) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => HomeScreen(
                              loginEntity: state.loginEntity,
                            )),
                    (_) => false);
              });
            }
            if (state is InvalidOTP) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("OTP is wrong/expired")));
              });
            }
            if (state is LoginFailed) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("something went wrong try again!")));
              });
            }
            if (state is LoginLoading) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                showLoaderDialog(context);
              });
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                  child: PasswordInputTextField(
                    controller: _controller,
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
                    if (_controller.text.isNotEmpty &&
                        _controller.text.length == 6) {
                      _loginCubit.verifyOtp(widget.phone, _controller.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Enter OTP")));
                    }
                  },
                  child: const Text("Verify"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: const Text("Loading..."),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(onWillPop: () async => false, child: alert);
      },
    );
  }
}
