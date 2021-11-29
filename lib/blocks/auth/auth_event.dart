part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginUserEvent extends AuthEvent {
  final String name;
  final String phone;
  final String id;

  LoginUserEvent({
    required this.name,
    required this.phone,
    required this.id,
  });

  @override
  List<Object> get props => [name, phone, id];
}

class GetProfileEvent extends AuthEvent {
  final String userId;

  GetProfileEvent({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}
