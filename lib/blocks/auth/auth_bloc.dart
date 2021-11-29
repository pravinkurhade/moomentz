import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';
import 'package:moomentz/models/profile/profile_response.dart';
import 'package:moomentz/models/updateprofile/update_profile_request.dart';

import '../../common/common/SharePreference.dart';
import '../../models/signin/signin_request.dart';
import '../../networking/rest_client.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final client = RestClient(Dio(BaseOptions(contentType: 'application/json')));
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    print('authbloc');
    if (event is LoginUserEvent) {
      try {
        yield LoadingState();
        print(event.name);
        print(event.phone);
        print(event.id);
        FirebaseMessaging messaging = FirebaseMessaging.instance;
        String? token = await messaging.getToken();
        var responseData = await client.signIn(SignInRequest(
            name: event.name,
            device_id: 'device_id',
            DpLink: 'DpLink',
            mobile_num: event.phone,
            id: event.id,
            fcm_token: token!));
        await AppSharedPreferences.setValue(key: 'id', value: responseData.id);
        var responseDataA = await client.updateToken(
            event.id, UpdateProfileRequest(fields: Fields(fcm_token: token)));
        print('token updated login');
        print(responseDataA.id);
        await AppSharedPreferences.setValue(key: 'login', value: 'success');
        yield LoadedState();
      } catch (e) {
        print("error msg here ${e.toString()}");
        FirebaseMessaging messaging = FirebaseMessaging.instance;
        String? token = await messaging.getToken();
        var responseData = await client.updateToken(
            event.id, UpdateProfileRequest(fields: Fields(fcm_token: token)));
        print('token updated login error');
        print(responseData.id);
        await AppSharedPreferences.setValue(key: 'login', value: 'success');
        yield LoadedState();
      }
    }

    if (event is GetProfileEvent) {
      try {
        yield LoadingState();
        print(event.userId);
        var responseData = await client.getProfile(event.userId);
        yield ProfileState(profileResponse: responseData);
      } catch (e) {
        print("error msg here ${e.toString()}");
        ErrorState(message: e.toString());
      }
    }
  }
}
