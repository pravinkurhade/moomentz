part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends AuthState {
  final int? status;
  final String? message;

  ErrorState({this.status, this.message});

  @override
  List<Object> get props => [];
}

class LoadedState extends AuthState {
  LoadedState();

  @override
  List<Object?> get props => [];
}

class ProfileState extends AuthState {
  final ProfileResponse profileResponse;

  ProfileState({required this.profileResponse});

  @override
  List<Object?> get props => [profileResponse];
}
