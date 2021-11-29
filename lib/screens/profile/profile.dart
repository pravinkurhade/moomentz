import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moomentz/blocks/auth/auth_bloc.dart';
import 'package:moomentz/common/common/SharePreference.dart';
import 'package:moomentz/common/common/constants.dart';
import 'package:moomentz/common/common/navigation.dart';
import 'package:moomentz/screens/signin/signin.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = 'profile_screen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        var user = FirebaseAuth.instance.currentUser;
        BlocProvider.of<AuthBloc>(context)
            .add(GetProfileEvent(userId: user!.uid));
      });
    });
    super.initState();
  }

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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigation.back(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                'images/backbutton.png',
                                fit: BoxFit.fill,
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Profile',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0),
                          ),
                        ),
                      ],
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is ProfileState) {}
                      },
                      builder: (context, state) {
                        if (state is ProfileState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Name : ${state.profileResponse.name}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Loading...',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25.0),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: raisedButtonStyle,
                    onPressed: () async {
                      FirebaseAuth.instance.signOut();
                      await AppSharedPreferences.setValue(
                          key: 'login', value: '');
                      Navigation.intentWithClearAllRoutes(
                          context, LoginScreen.routeName);
                    },
                    child: const Text('Logout'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
