import 'package:bus_tracker_app/core/error/failure.dart';
import 'package:bus_tracker_app/core/usecase/usecase.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/entities/position.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/repositories/location_publishing_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateBusLocation implements UseCase<void, UpdateBusLocationParams> {
  final LocationPublishingRepository repository;

  UpdateBusLocation(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateBusLocationParams params) {
    return repository.updateLocation(params.tripId, params.position);
  }
}

class UpdateBusLocationParams {
  final int tripId;
  final PositionEntity position;

  UpdateBusLocationParams({required this.tripId, required this.position});
}
