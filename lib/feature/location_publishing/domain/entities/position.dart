import 'package:equatable/equatable.dart';

class PositionEntity extends Equatable {
  final double lat;
  final double lng;
  final DateTime timestamp;
  final double? accuracy;
  final double? speed;

  const PositionEntity({
    required this.lat,
    required this.lng,
    required this.timestamp,
    this.accuracy,
    this.speed,
  });

  @override
  List<Object?> get props => [lat, lng, timestamp, accuracy, speed];
}
