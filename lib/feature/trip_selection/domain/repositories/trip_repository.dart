import 'package:bus_tracker_app/core/error/failure.dart';
import 'package:bus_tracker_app/feature/trip_selection/domain/entities/trip.dart';
import 'package:dartz/dartz.dart';

abstract class TripRepository{
  Future<Either<Failure, TripEntity?>> getActiveTrip();
}