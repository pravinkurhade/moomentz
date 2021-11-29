import 'package:get_it/get_it.dart';

import 'blocks/auth/auth_bloc.dart';
import 'blocks/moomentz/moomentz_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(() => MoomentzBloc());
  getIt.registerFactory(() => AuthBloc());
}
