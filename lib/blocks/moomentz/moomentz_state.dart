part of 'moomentz_bloc.dart';

@immutable
abstract class MoomentzState {}

class MoomentzInitial extends MoomentzState {}

class LoadingState extends MoomentzState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends MoomentzState {
  final int? status;
  final String? message;

  ErrorState({this.status, this.message});

  @override
  List<Object> get props => [];
}

class MomentsLoaded extends MoomentzState {
  final MomentsResponse momentsResponse;
  MomentsLoaded({required this.momentsResponse});

  @override
  List<Object?> get props => [momentsResponse];
}

class MomentsByCategoryLoaded extends MoomentzState {
  final MomentsResponse momentsResponse;
  MomentsByCategoryLoaded({required this.momentsResponse});

  @override
  List<Object?> get props => [momentsResponse];
}

class MyMomentsLoaded extends MoomentzState {
  final MyMomentsResponse upcomingMomentsResponse;
  final MyMomentsResponse historyMomentsResponse;

  MyMomentsLoaded(
      {required this.upcomingMomentsResponse,
      required this.historyMomentsResponse});

  @override
  List<Object?> get props => [upcomingMomentsResponse];
}

class MomentLoaded extends MoomentzState {
  final Moment moment;
  MomentLoaded({required this.moment});

  @override
  List<Object?> get props => [moment];
}

class JoinMomentLoaded extends MoomentzState {
  final JoinResponse joinResponse;
  JoinMomentLoaded({required this.joinResponse});

  @override
  List<Object?> get props => [joinResponse];
}

class CreateMomentLoaded extends MoomentzState {
  final CreateMomentResponse createMomentResponse;
  CreateMomentLoaded({required this.createMomentResponse});

  @override
  List<Object?> get props => [createMomentResponse];
}

class CategoriesLoaded extends MoomentzState {
  final CategoriesResponse categoriesResponse;
  CategoriesLoaded({required this.categoriesResponse});

  @override
  List<Object?> get props => [categoriesResponse];
}

class MessageLoaded extends MoomentzState {
  final MessageResponse messageResponse;
  MessageLoaded({required this.messageResponse});

  @override
  List<Object?> get props => [messageResponse];
}

class ReviewAddedLoaded extends MoomentzState {
  final MessageResponse messageResponse;
  ReviewAddedLoaded({required this.messageResponse});

  @override
  List<Object?> get props => [messageResponse];
}

class ReviewLoaded extends MoomentzState {
  final ReviewsResponse reviewsResponse;
  ReviewLoaded({required this.reviewsResponse});

  @override
  List<Object?> get props => [reviewsResponse];
}
