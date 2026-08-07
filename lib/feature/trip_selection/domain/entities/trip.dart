import 'package:bus_tracker_app/feature/trip_selection/domain/entities/route.dart';
import 'package:equatable/equatable.dart';

enum TripStatus { active, finished }

class TripEntity extends Equatable {
  final int id;
  final int routeId;
  final String busPlate;
  final TripStatus status;
  final RouteEntity? route;

  const TripEntity({
    required this.id,
    required this.routeId,
    required this.busPlate,
    required this.status,
    this.route,
  });

  @override
  List<Object?> get props => [id, routeId, busPlate, status, route];
}
