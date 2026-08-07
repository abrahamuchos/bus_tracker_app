import 'package:bus_tracker_app/core/error/exceptions.dart';
import 'package:bus_tracker_app/core/error/failure.dart';
import 'package:bus_tracker_app/feature/trip_selection/data/datasources/trip_selection_remote_data_source.dart';
import 'package:bus_tracker_app/feature/trip_selection/domain/entities/trip.dart';
import 'package:bus_tracker_app/feature/trip_selection/domain/repositories/trip_repository.dart';
import 'package:dartz/dartz.dart';

class TripRepositoryImpl implements TripRepository {
  final TripSelectionRemoteDataSource remoteDataSource;

  TripRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, TripEntity?>> getActiveTrip() async {
    try {
      final trip = await remoteDataSource.getActiveTrip();

      return Right(trip);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
