import 'dart:async';

import 'package:bus_tracker_app/core/error/failure.dart';
import 'package:bus_tracker_app/core/utils/ansi_colors.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/entities/position.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/error/location_failure.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<Either<Failure, PositionEntity>> getCurrentPosition() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 8),
        ),
      );

      return Right(
        PositionEntity(
          lat: position.latitude,
          lng: position.longitude,
          timestamp: position.timestamp,
          accuracy: position.accuracy,
          speed: position.speed,
        ),
      );
    } on TimeoutException {
      AnsiColor.printToDebug("[GEOLOCATOR] TIMEOUT EXCEPTION", AnsiColor.red);

      return Left(LocationFailure(LocationFailureType.positionUnavailable));
    } on LocationServiceDisabledException {
      AnsiColor.printToDebug(
        "[GEOLOCATOR] LOCATION DISABLED EXCEPTION",
        AnsiColor.red,
      );

      return Left(LocationFailure(LocationFailureType.serviceDisabled));
    } catch (e) {
      AnsiColor.printToDebug("[GEOLOCATOR] ERROR LOCATION", AnsiColor.red);

      return Left(LocationFailure(LocationFailureType.positionUnavailable));
    }
  }

  @override
  Future<bool> isLocationServiceEnabled() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    AnsiColor.printToDebug(
      "[GEOLOCATOR] SERVICE ENABLE ${isServiceEnabled.toString()}",
      (isServiceEnabled ? AnsiColor.green : AnsiColor.red),
    );

    return isServiceEnabled;
  }

  @override
  Future<Either<Failure, PermissionRequestResult>> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    switch (permission) {
      case LocationPermission.denied:
        return Right(PermissionRequestResult.denied);
      case LocationPermission.deniedForever:
        return Right(PermissionRequestResult.deniedForever);
      case LocationPermission.whileInUse:
      case LocationPermission.always:
        return Right(PermissionRequestResult.granted);
      case LocationPermission.unableToDetermine:
        return Left(
          LocationFailure(
            LocationFailureType.positionUnavailable,
            'Error to location, unable to determine',
          ),
        );
    }
  }
}
