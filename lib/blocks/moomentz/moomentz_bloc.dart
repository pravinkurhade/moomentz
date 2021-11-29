import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:moomentz/models/categories_response.dart';
import 'package:moomentz/models/join_response.dart';
import 'package:moomentz/models/messages/message_request.dart';
import 'package:moomentz/models/messages/message_response.dart';
import 'package:moomentz/models/my_moments_response.dart';
import 'package:moomentz/models/reviews/addreview_request.dart';
import 'package:moomentz/models/reviews/reviews_response.dart';
import '../../models/creratemoment/createmoment_request.dart';
import '../../models/creratemoment/createmoment_response.dart';
import '../../models/moment.dart';
import '../../models/moments/moments_response.dart';
import '../../networking/rest_client.dart';

part 'moomentz_event.dart';
part 'moomentz_state.dart';

class MoomentzBloc extends Bloc<MoomentzEvent, MoomentzState> {
  final client = RestClient(Dio(BaseOptions(contentType: 'application/json')));

  MoomentzBloc() : super(MoomentzInitial());

  @override
  Stream<MoomentzState> mapEventToState(
    MoomentzEvent event,
  ) async* {
    if (event is GetMomentsEvent) {
      try {
        yield LoadingState();
        var responseData = await client.getMoments(
            event.long.toString(), event.lat.toString());
        yield MomentsLoaded(momentsResponse: responseData);
      } catch (e) {
        print('error msg here ${e.toString()}');
        ErrorState(message: e.toString());
      }
    }

    if (event is GetCategoriesEvent) {
      try {
        var responseData = await client.getCategories();
        yield CategoriesLoaded(categoriesResponse: responseData);
      } catch (e) {
        print('error msg here ${e.toString()}');
        ErrorState(message: e.toString());
      }
    }

    if (event is SearchMomentEvent) {
      try {
        yield LoadingState();
        var responseData = await client.searchMoments(
            event.long.toString(), event.lat.toString(), event.text);
        yield MomentsLoaded(momentsResponse: responseData);
      } catch (e) {
        print('error msg here ${e.toString()}');
        ErrorState(message: e.toString());
      }
    }

    if (event is GetMomentsByCategoryEvent) {
      try {
        yield LoadingState();
        var responseData = await client.getMomentsByCategory(
            event.long.toString(), event.lat.toString(), event.category);
        yield MomentsByCategoryLoaded(momentsResponse: responseData);
      } catch (e) {
        print('error msg here ${e.toString()}');
        ErrorState(message: e.toString());
      }
    }

    if (event is MyMomentsEvent) {
      try {
        yield LoadingState();
        print(event.id);
        var getUpcomingMomentById =
            await client.getUpcomingMomentById(event.id);
        var getHistoryMomentById = await client.getHistoryMomentById(event.id);
        print(getUpcomingMomentById.moments.length.toString());
        yield MyMomentsLoaded(
            upcomingMomentsResponse: getUpcomingMomentById,
            historyMomentsResponse: getHistoryMomentById);
      } catch (e) {
        print(e.toString());
        ErrorState(message: e.toString());
      }
    }

    if (event is GetMomentEvent) {
      try {
        yield LoadingState();
        var responseData = await client.getMomentById(event.id);
        yield MomentLoaded(moment: responseData);
      } catch (e) {
        print('error msg here ${e.toString()}');
        ErrorState(message: e.toString());
      }
    }

    if (event is CreateMomentEvent) {
      try {
        yield LoadingState();
        var responseData = await client.createMoment(event.createMoment);
        yield CreateMomentLoaded(createMomentResponse: responseData);
      } catch (e) {
        print('error msg here ${e.toString()}');
        ErrorState(message: e.toString());
      }
    }

    if (event is JoinMomentEvent) {
      try {
        var responseData = await client.joinMoment(event.id, event.userId);
        yield JoinMomentLoaded(joinResponse: responseData);
      } catch (e) {
        print('error msg here ${e.toString()}');
        ErrorState(message: e.toString());
      }
    }

    if (event is SendMessageGuestEvent) {
      try {
        var responseData = await client.guestMessage(
            MessageRequest(Message: event.message), event.id, event.userId);
        yield MessageLoaded(messageResponse: responseData);
      } catch (e) {
        print('error msg here ${e.toString()}');
        ErrorState(message: e.toString());
      }
    }

    if (event is SendMessageHostEvent) {
      try {
        var responseData = await client.hostMessage(
            MessageRequest(Message: event.message), event.id, event.userId);
        yield MessageLoaded(messageResponse: responseData);
      } catch (e) {
        print('error msg here ${e.toString()}');
        ErrorState(message: e.toString());
      }
    }

    if (event is AddReviewEvent) {
      try {
        var responseData = await client.addReview(
            AddReviewRequest(message: event.message, reviewer_id: event.userId),
            event.id);
        yield ReviewAddedLoaded(messageResponse: responseData);
      } catch (e) {
        print('error msg here ${e.toString()}');
        ErrorState(message: e.toString());
      }
    }

    if (event is GetReviewsEvent) {
      try {
        var responseData = await client.getReviews(event.id);
        yield ReviewLoaded(reviewsResponse: responseData);
      } catch (e) {
        print('error msg here ${e.toString()}');
        ErrorState(message: e.toString());
      }
    }
  }
}
