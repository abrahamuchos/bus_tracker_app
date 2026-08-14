import 'package:bus_tracker_app/core/error/failure.dart';
import 'package:bus_tracker_app/core/usecase/usecase.dart';
import 'package:bus_tracker_app/feature/trip_selection/domain/entities/trip.dart';
import 'package:bus_tracker_app/feature/trip_selection/domain/repositories/trip_repository.dart';
import 'package:dartz/dartz.dart';

class GetActiveTrip implements UseCase<TripEntity, NoParams>{
  final TripRepository repository;

  GetActiveTrip(this.repository);

  @override
  Future<Either<Failure, TripEntity?>> call(NoParams params) {
    return repository.getActiveTrip();
  }
}