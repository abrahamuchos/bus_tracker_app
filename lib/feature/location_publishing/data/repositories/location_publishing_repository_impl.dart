import 'package:bus_tracker_app/core/error/exceptions.dart';
import 'package:bus_tracker_app/core/error/failure.dart';
import 'package:bus_tracker_app/feature/location_publishing/data/datasource/location_publishing_remote_data_source.dart';
import 'package:bus_tracker_app/feature/location_publishing/data/models/position_request_params.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/entities/position.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/repositories/location_publishing_repository.dart';
import 'package:dartz/dartz.dart';

class LocationPublishingRepositoryImpl implements LocationPublishingRepository {
  final LocationPublishingRemoteDataSource remoteDataSource;

  LocationPublishingRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> updateLocation(int tripId, PositionEntity positionEntity,) async {
    try {
      final positionReq = PositionRequestParams.fromEntity(positionEntity);
      await remoteDataSource.updateLocation(tripId, positionReq);

      return Right(null);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
