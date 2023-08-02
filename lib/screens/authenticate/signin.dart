import 'package:mobi_chat/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'components/custom_tff.dart';

class Signin extends StatefulWidget {
  final Function toggleView;

  const Signin({super.key, required this.toggleView});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final String _emailTextHint = 'Enter your Email';
  final String _passwordTextHint = 'Enter your Password';

  final IconData _emailIconData = Icons.email;
  final IconData _passwordIconData = Icons.lock;

  final String _emailValidator = 'Enter an email';
  final String _passwordValidator = 'Enter a password 6+ characters long';

  final bool _emailIsObscure = false;
  final bool _passwordIsObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade400, Colors.blue.shade800])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            const Text(
              "Login",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  fontFamily: "OpenSans"),
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                        controller: _emailController,
                        hintText: _emailTextHint,
                        iconData: _emailIconData,
                        validatorResult: _emailValidator,
                        isobscure: _emailIsObscure),
                    CustomTextFormField(
                        controller: _passwordController,
                        hintText: _passwordTextHint,
                        iconData: _passwordIconData,
                        validatorResult: _passwordValidator,
                        isobscure: _passwordIsObscure),
                    _loginBTN(),
                    _newAcc(),
                  ],
                )),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginBTN() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 38, vertical: 32),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _authService
                .signin(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim())
                .then((result) {
              if (result[0] == null) {
                Fluttertoast.showToast(
                  msg: result[1],
                );
              }
            });
          }
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(8),
            backgroundColor: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        child: Text(
          "Login",
          style: TextStyle(fontSize: 24, color: Colors.blue.shade600),
        ),
      ),
    );
  }

  Widget _newAcc() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Create new account",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        TextButton(
            onPressed: () {
              widget.toggleView();
            },
            child: Text(
              "Sign Up",
              style: TextStyle(fontSize: 16, color: Colors.blue.shade300),
            ))
      ],
    );
  }
}
