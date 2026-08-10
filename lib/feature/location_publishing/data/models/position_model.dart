import 'package:bus_tracker_app/feature/location_publishing/domain/entities/position.dart';

class PositionModel extends PositionEntity {
  const PositionModel({
    required super.lat,
    required super.lng,
    required super.timestamp,
    super.accuracy,
    super.speed,
  });

}
