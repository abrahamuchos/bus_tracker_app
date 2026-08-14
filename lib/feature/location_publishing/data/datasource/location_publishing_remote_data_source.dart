
import 'package:bus_tracker_app/core/error/exceptions.dart';
import 'package:bus_tracker_app/feature/location_publishing/data/datasource/location_publishing_api.dart';
import 'package:bus_tracker_app/feature/location_publishing/data/models/position_request_params.dart';
import 'package:dio/dio.dart';

abstract class LocationPublishingRemoteDataSource{
  Future<void> updateLocation(int tripId, PositionRequestParams positionReq);
}

class LocationPublishingRemoteDataSourceImpl implements LocationPublishingRemoteDataSource{
  final LocationPublishingApi api;

  LocationPublishingRemoteDataSourceImpl(this.api);


  @override
  Future<void> updateLocation(int tripId, PositionRequestParams positionReq) async{
    try{
      return await api.updateLocation(tripId, positionReq);
    }on DioException catch(e){
      if(e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout){
        throw NetworkException(e.message ?? 'Error on network');
      }

      throw ServerException(e.message ?? 'Error retrieving the trip');
    }
  }

}