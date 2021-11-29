import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moomentz/common/common/navigation.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../../blocks/auth/auth_bloc.dart';
import '../dashboard/dashboard.dart';

class OTPScreen extends StatefulWidget {
  static String routeName = 'otp_screen';

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Colors.blue,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final phone = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      key: _scaffoldkey,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoadedState) {
            Navigation.intentWithClearAllRoutes(
                context, DashboardScreen.routeName);
          }
          if (state is ErrorState) {
            print(state.message);
            final snackBar = SnackBar(content: Text(state.message.toString()));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Center(
                      child: Text(
                        'Verify +91-$phone',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Center(
                      child: Text(
                        'Enter OTP',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: PinPut(
                    fieldsCount: 6,
                    textStyle:
                        const TextStyle(fontSize: 25.0, color: Colors.black),
                    eachFieldWidth: 45.0,
                    eachFieldHeight: 60.0,
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: pinPutDecoration,
                    selectedFieldDecoration: pinPutDecoration,
                    followingFieldDecoration: pinPutDecoration,
                    pinAnimationType: PinAnimationType.fade,
                    onSubmit: (pin) async {
                      try {
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: _verificationCode!,
                                smsCode: pin))
                            .then((value) async {
                          if (value.user != null) {
                            BlocProvider.of<AuthBloc>(context).add(
                                LoginUserEvent(
                                    name: 'Pravin kurhade',
                                    id: value.user!.uid,
                                    phone: phone!));
                          }
                        });
                      } catch (e) {
                        FocusScope.of(context).unfocus();
                        _scaffoldkey.currentState!.showSnackBar(
                            const SnackBar(content: Text('invalid OTP')));
                      }
                    },
                  ),
                ),
                const Text(
                  'Resend OTP',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _verifyPhone(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phone',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            if (value.user != null) {
              BlocProvider.of<AuthBloc>(context).add(LoginUserEvent(
                  name: 'Pravin kurhade', id: value.user!.uid, phone: phone));
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
            print(_verificationCode);
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
            print(_verificationCode);
          });
        },
        timeout: const Duration(seconds: 120));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        final phone = ModalRoute.of(context)!.settings.arguments as String?;
        print(phone);
        _verifyPhone(phone!);
      });
    });
  }
}
