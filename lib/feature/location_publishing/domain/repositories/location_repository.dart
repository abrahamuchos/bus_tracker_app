import 'package:bus_tracker_app/core/error/failure.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/entities/position.dart';
import 'package:dartz/dartz.dart';

enum PermissionRequestResult { granted, denied, deniedForever }

abstract class LocationRepository {
  Future<Either<Failure, PermissionRequestResult>> requestPermission();
  Future<bool> isLocationServiceEnabled();
  Future<Either<Failure, PositionEntity>> getCurrentPosition();
}
