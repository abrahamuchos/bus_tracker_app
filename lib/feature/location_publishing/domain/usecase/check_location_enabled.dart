import 'package:bus_tracker_app/core/error/failure.dart';
import 'package:bus_tracker_app/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/repositories/location_repository.dart';

class CheckLocationEnabled implements UseCase<bool, NoParams> {
  final LocationRepository repository;

  CheckLocationEnabled(this.repository);

  @override
  Future<Either<Failure, bool?>> call(NoParams params) async{
    final isEnabled = await repository.isLocationServiceEnabled();
    return Right(isEnabled);
  }

  
}
