import 'package:bus_tracker_app/core/error/exceptions.dart';
import 'package:bus_tracker_app/feature/trip_selection/data/datasources/trip_selection_api.dart';
import 'package:bus_tracker_app/feature/trip_selection/data/models/trip_model.dart';
import 'package:dio/dio.dart';

abstract class TripSelectionRemoteDataSource {
  Future<TripModel?> getActiveTrip();
}

class TripSelectionRemoteDataSourceImpl
    implements TripSelectionRemoteDataSource {
  final TripSelectionApi api;

  TripSelectionRemoteDataSourceImpl(this.api);

  @override
  Future<TripModel?> getActiveTrip() async {
    try {
      return await api.getActiveTrip();
    } on DioException catch (e) {
      //Si no hay activo el backend me retorna un 404
      if (e.type == DioExceptionType.badResponse && e.response?.statusCode == 404) {
        return null;
      }
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw NetworkException();
      }
      throw ServerException(e.message ?? 'Error retrieving the trip');
    }
  }
}
