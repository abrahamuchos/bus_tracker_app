import 'package:bus_tracker_app/core/error/failure.dart';
import 'package:bus_tracker_app/core/usecase/usecase.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';

class RequestLocationPermission implements UseCase<PermissionRequestResult, NoParams>{
  final LocationRepository repository;

  RequestLocationPermission(this.repository);


  @override
  Future<Either<Failure, PermissionRequestResult?>> call(NoParams params) {
    return repository.requestPermission();
  }

}