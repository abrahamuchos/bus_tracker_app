import 'package:bus_tracker_app/feature/location_publishing/domain/entities/position.dart';

class PositionRequestParams {
  final double lat;
  final double lng;

  PositionRequestParams({required this.lat, required this.lng});

  factory PositionRequestParams.fromEntity(PositionEntity entity) {
    return PositionRequestParams(lat: entity.lat, lng: entity.lng);
  }

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};
}


