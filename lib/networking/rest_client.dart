import 'package:dio/dio.dart';
import 'package:moomentz/models/categories_response.dart';
import 'package:moomentz/models/join_response.dart';
import 'package:moomentz/models/messages/message_request.dart';
import 'package:moomentz/models/messages/message_response.dart';
import 'package:moomentz/models/my_moments_response.dart';
import 'package:moomentz/models/profile/profile_response.dart';
import 'package:moomentz/models/reviews/addreview_request.dart';
import 'package:moomentz/models/reviews/reviews_response.dart';
import 'package:moomentz/models/updateprofile/update_profile_request.dart';
import 'package:retrofit/http.dart';

import '../models/creratemoment/createmoment_request.dart';
import '../models/creratemoment/createmoment_response.dart';
import '../models/moment.dart';
import '../models/moments/moments_response.dart';
import '../models/signin/signin_request.dart';
import '../models/signin/signin_response.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://35.227.151.254/v1/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('feed?long={long}&lat={lat}')
  Future<MomentsResponse> getMoments(
      @Path('long') String long, @Path('lat') String lat);

  @GET('feed?long={long}&lat={lat}&search={text}')
  Future<MomentsResponse> searchMoments(@Path('long') String long,
      @Path('lat') String lat, @Path('text') String text);

  @GET('feed?long={long}&lat={lat}&category={category}')
  Future<MomentsResponse> getMomentsByCategory(@Path('long') String long,
      @Path('lat') String lat, @Path('category') String category);

  @GET('moments/{id}')
  Future<Moment> getMomentById(@Path('id') String id);

  @GET('moments/upcoming?user_id={id}')
  Future<MyMomentsResponse> getUpcomingMomentById(@Path('id') String id);

  @GET('moments/history/user_id={id}')
  Future<MyMomentsResponse> getHistoryMomentById(@Path('id') String id);

  @GET('moments/categories')
  Future<CategoriesResponse> getCategories();

  @POST('users')
  Future<SignInResponse> signIn(@Body() SignInRequest signInRequest);

  @PUT('users/{id}')
  Future<SignInResponse> updateToken(
      @Path('id') String id, @Body() UpdateProfileRequest updateProfileRequest);

  @POST('moments/{id}/join?user_id={userID}')
  Future<JoinResponse> joinMoment(
      @Path('id') String id, @Path('userID') String userID);

  @POST('moments')
  Future<CreateMomentResponse> createMoment(@Body() CreateMoment createMoment);

  @POST('moments/{id}/message/guest?user_id=={userID}')
  Future<MessageResponse> guestMessage(@Body() MessageRequest messageRequest,
      @Path('id') String id, @Path('userID') String userID);

  @POST('moments/{id}/message/host?user_id=={userID}')
  Future<MessageResponse> hostMessage(@Body() MessageRequest messageRequest,
      @Path('id') String id, @Path('userID') String userID);

  @POST('moments/{id}/reviews')
  Future<MessageResponse> addReview(
      @Body() AddReviewRequest addReviewRequest, @Path('id') String id);

  @GET('moments/{id}/reviews')
  Future<ReviewsResponse> getReviews(@Path('id') String id);

  @GET('users/{id}')
  Future<ProfileResponse> getProfile(@Path('id') String id);
}
