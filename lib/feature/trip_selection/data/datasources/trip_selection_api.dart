import 'package:bus_tracker_app/feature/trip_selection/data/models/trip_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'trip_selection_api.g.dart';


@RestApi()
abstract class TripSelectionApi{
  factory TripSelectionApi(Dio dio, {String baseUrl}) = _TripSelectionApi;

  @GET('/trips/active')
  Future<TripModel> getActiveTrip();
}