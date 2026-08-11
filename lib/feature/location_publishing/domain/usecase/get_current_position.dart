import 'package:bus_tracker_app/core/error/failure.dart';
import 'package:bus_tracker_app/core/usecase/usecase.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/entities/position.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentPosition implements UseCase<PositionEntity, NoParams>{
  final LocationRepository repository;

  GetCurrentPosition(this.repository);

  @override
  Future<Either<Failure, PositionEntity?>> call(NoParams params) {
    return repository.getCurrentPosition();
  }

}