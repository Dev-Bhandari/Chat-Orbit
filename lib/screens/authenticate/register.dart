import 'package:mobi_chat/screens/authenticate/components/custom_tff.dart';
import 'package:mobi_chat/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final String _nameTextHint = 'Name';
  final String _emailTextHint = 'Enter your Email';
  final String _passwordTextHint = 'Enter your Password';

  final IconData _nameIconData = Icons.person;
  final IconData _emailIconData = Icons.email;
  final IconData _passwordIconData = Icons.lock;

  final String _nameValidator = 'Enter a name';
  final String _emailValidator = 'Enter an email';
  final String _passwordValidator = 'Enter a password 6+ characters long';

  final bool _nameIsObscure = false;
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
              flex: 3,
            ),
            const Text(
              "Register",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  fontFamily: "OpenSans"),
            ),
            const Spacer(
              flex: 1,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                        controller: _nameController,
                        hintText: _nameTextHint,
                        iconData: _nameIconData,
                        validatorResult: _nameValidator,
                        isobscure: _nameIsObscure),
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
                    _registerBTN(),
                    _signin()
                  ],
                )),
            const Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerBTN() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 38, vertical: 32),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _authService.register(
                name: _nameController.text.trim(),
                email: _emailController.text.trim(),
                password: _passwordController.text);
            // LocalStorage.setEmail(_emailController.text.trim());
            // LocalStorage.setPass(_passwordController.text.trim());
            // LocalStorage.setIsLoggedOut(false);
          }
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(8),
            backgroundColor: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        child: Text(
          "Register",
          style: TextStyle(fontSize: 24, color: Colors.blue.shade600),
        ),
      ),
    );
  }

  Widget _signin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        TextButton(
            onPressed: () {
              widget.toggleView();
            },
            child: Text(
              "Sign In",
              style: TextStyle(fontSize: 16, color: Colors.blue.shade300),
            ))
      ],
    );
  }
}
