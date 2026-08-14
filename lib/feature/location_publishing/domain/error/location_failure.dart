import 'package:bus_tracker_app/core/error/failure.dart';

enum LocationFailureType{
  permissionDenied,        // se puede volver a pedir
  permissionDeniedForever, // hay que mandar a Settings
  serviceDisabled,         // el GPS del dispositivo está apagado
  positionUnavailable,     // timeout o no se pudo leer
}

class LocationFailure extends Failure{
  final LocationFailureType type;

  const LocationFailure(this.type, [super.message = 'Error to location']);

  @override
  List<Object?> get props => [...super.props, type];
}