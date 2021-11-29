import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moomentz/screens/categorylist/categorylist.dart';
import 'package:moomentz/screens/messaging/messaging.dart';
import 'package:moomentz/screens/momentdetails/momentsdetails.dart';
import 'package:moomentz/screens/profile/profile.dart';
import 'package:moomentz/screens/reviews/reviews.dart';

import 'blocks/auth/auth_bloc.dart';
import 'blocks/moomentz/moomentz_bloc.dart';
import 'injector_container.dart' as di;
import 'screens/create_mooments/create_mooments.dart';
import 'screens/dashboard/dashboard.dart';
import 'screens/home/home.dart';
import 'screens/signin/otp.dart';
import 'screens/signin/signin.dart';
import 'screens/splash/splash_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  print("Handling a background message: ${message.data}");
}

void main() async {
  await di.init();
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getToken();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  print('token');
  print(token);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moomentz',
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginScreen.routeName: (context) => BlocProvider<AuthBloc>(
              create: (context) => di.getIt<AuthBloc>(),
              child: LoginScreen(),
            ),
        ProfileScreen.routeName: (context) => BlocProvider<AuthBloc>(
              create: (context) => di.getIt<AuthBloc>(),
              child: ProfileScreen(),
            ),
        OTPScreen.routeName: (context) => BlocProvider<AuthBloc>(
              create: (context) => di.getIt<AuthBloc>(),
              child: OTPScreen(),
            ),
        DashboardScreen.routeName: (context) => BlocProvider<MoomentzBloc>(
              create: (context) => di.getIt<MoomentzBloc>(),
              child: const DashboardScreen(),
            ),
        CreateMomentScreen.routeName: (context) => BlocProvider<MoomentzBloc>(
              create: (context) => di.getIt<MoomentzBloc>(),
              child: const CreateMomentScreen(),
            ),
        HomeScreen.routeName: (context) => BlocProvider<MoomentzBloc>(
              create: (context) => di.getIt<MoomentzBloc>(),
              child: const HomeScreen(),
            ),
        MomentDetails.routeName: (context) => BlocProvider<MoomentzBloc>(
              create: (context) => di.getIt<MoomentzBloc>(),
              child: const MomentDetails(),
            ),
        MessagingScreen.routeName: (context) => BlocProvider<MoomentzBloc>(
              create: (context) => di.getIt<MoomentzBloc>(),
              child: const MessagingScreen(),
            ),
        ReviewScreen.routeName: (context) => BlocProvider<MoomentzBloc>(
              create: (context) => di.getIt<MoomentzBloc>(),
              child: const ReviewScreen(),
            ),
        CategoryList.routeName: (context) => BlocProvider<MoomentzBloc>(
              create: (context) => di.getIt<MoomentzBloc>(),
              child: const CategoryList(),
            ),
      },
    );
  }
}
