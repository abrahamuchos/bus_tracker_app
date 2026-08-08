import 'package:bus_tracker_app/feature/trip_selection/data/models/route_model.dart';
import 'package:bus_tracker_app/feature/trip_selection/domain/entities/trip.dart';

class TripModel extends TripEntity {
  const TripModel({
    required super.id,
    required super.busPlate,
    required super.status,
    super.route
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data =
        json.containsKey('data') ? json['data'] as Map<String, dynamic> : json;

    return TripModel(
      id: data['id'] as int,
      busPlate: data['busPlate'] as String,
      status: data['status'] == 'active' ? TripStatus.active : TripStatus.finished,
      route: RouteModel.fromJson(data['route'] as Map<String, dynamic>),
    );
  }
}