import 'package:bus_tracker_app/feature/trip_selection/domain/entities/route.dart';
import 'package:equatable/equatable.dart';

enum TripStatus {
  active,
  finished;

  String get label => switch (this){
    TripStatus.active => 'Activo',
    TripStatus.finished => 'Finalizado'
  };

}

class TripEntity extends Equatable {
  final int id;
  final String busPlate;
  final TripStatus status;
  final RouteEntity? route;

  const TripEntity({
    required this.id,
    required this.busPlate,
    required this.status,
    this.route,
  });

  @override
  List<Object?> get props => [id, busPlate, status, route];
}
