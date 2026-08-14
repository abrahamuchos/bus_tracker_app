import 'package:bus_tracker_app/core/constants/api_constants.dart';
import 'package:bus_tracker_app/feature/location_publishing/data/models/position_request_params.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'location_publishing_api.g.dart';

@RestApi()
abstract class LocationPublishingApi {
  factory LocationPublishingApi(Dio dio, {String baseUrl}) = _LocationPublishingApi;

  @POST(ApiConstants.updateTripLocation)
  Future<void> updateLocation(@Path('trip') int tripId, @Body() PositionRequestParams positionReq);

}