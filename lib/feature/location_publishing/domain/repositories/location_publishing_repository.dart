import 'package:bus_tracker_app/core/error/failure.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/entities/position.dart';
import 'package:dartz/dartz.dart';

abstract class LocationPublishingRepository{
  Future<Either<Failure, void>> updateLocation(int tripId, PositionEntity position);

}


