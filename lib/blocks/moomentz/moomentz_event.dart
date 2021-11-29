part of 'moomentz_bloc.dart';

abstract class MoomentzEvent {}

class GetMomentsEvent extends MoomentzEvent {
  double long;
  double lat;

  GetMomentsEvent({required this.long, required this.lat});

  @override
  List<Object> get props => [long, lat];
}

class GetMomentsByCategoryEvent extends MoomentzEvent {
  double long;
  double lat;
  String category;

  GetMomentsByCategoryEvent(
      {required this.long, required this.lat, required this.category});

  @override
  List<Object> get props => [long, lat, category];
}

class GetMomentEvent extends MoomentzEvent {
  String id;

  GetMomentEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class GetReviewsEvent extends MoomentzEvent {
  String id;

  GetReviewsEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class SearchMomentEvent extends MoomentzEvent {
  String text;
  double long;
  double lat;

  SearchMomentEvent(
      {required this.text, required this.long, required this.lat});

  @override
  List<Object> get props => [text, long, lat];
}

class CreateMomentEvent extends MoomentzEvent {
  CreateMoment createMoment;

  CreateMomentEvent({required this.createMoment});

  @override
  List<Object> get props => [createMoment];
}

class MyMomentsEvent extends MoomentzEvent {
  String id;

  MyMomentsEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class JoinMomentEvent extends MoomentzEvent {
  String id;
  String userId;

  JoinMomentEvent({required this.id, required this.userId});

  @override
  List<Object> get props => [id, userId];
}

class SendMessageGuestEvent extends MoomentzEvent {
  String id;
  String userId;
  String message;

  SendMessageGuestEvent(
      {required this.id, required this.userId, required this.message});

  @override
  List<Object> get props => [id, userId, message];
}

class SendMessageHostEvent extends MoomentzEvent {
  String id;
  String userId;
  String message;

  SendMessageHostEvent(
      {required this.id, required this.userId, required this.message});

  @override
  List<Object> get props => [id, userId, message];
}

class AddReviewEvent extends MoomentzEvent {
  String id;
  String userId;
  String message;

  AddReviewEvent(
      {required this.id, required this.userId, required this.message});

  @override
  List<Object> get props => [id, userId, message];
}

class GetCategoriesEvent extends MoomentzEvent {
  GetCategoriesEvent();

  @override
  List<Object> get props => [];
}
