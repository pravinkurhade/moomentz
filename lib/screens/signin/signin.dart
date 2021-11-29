import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:moomentz/common/common/constants.dart';

import 'otp.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 100,
              alignment: Alignment.center, // This is needed
              child: Image.asset(
                'images/Moomentz.png',
                fit: BoxFit.contain,
                width: 300,
              ),
            ),
            const Text(
              'Sign In',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('+91'),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                style: raisedButtonStyle,
                onPressed: () {
                  Navigator.pushNamed(context, OTPScreen.routeName,
                      arguments: _controller.text);
                },
                child: const Text('Send OTP'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
