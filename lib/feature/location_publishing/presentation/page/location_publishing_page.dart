import 'package:bus_tracker_app/feature/location_publishing/domain/entities/position.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/error/location_failure.dart';
import 'package:bus_tracker_app/feature/location_publishing/presentation/bloc/location_publishing_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bus_tracker_app/core/di/injection_container.dart';
import 'package:geolocator/geolocator.dart';

class LocationPublishingPage extends StatelessWidget {
  final int tripId;

  const LocationPublishingPage({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocationPublishingCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text('Location Publishing')),
        body: BlocBuilder<LocationPublishingCubit, LocationPublishingState>(
          builder: (context, state) {
            return switch (state) {
              InitialState() => _buildInitial(context),
              PermissionDeniedState() => _buildPermissionDeniedState(context),
              PermissionDeniedForeverState() =>
                _buildPermissionDeniedForeverState(context),
              ServiceDisabledState() => _buildServiceDisabledState(context),
              LocationErrorState(:final message) => _buildLocationErrorState(context, message),
              PublishingState(:final lastPosition, :final lastError) =>
                _buildPublishingState(context, lastPosition, lastError),
            };
          },
        ),
      ),
    );
  }

  Widget _buildInitial(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            context.read<LocationPublishingCubit>().startPublishing(tripId);
          },
          child: Text('Iniciar Viaje'),
        ),
      ],
    );
  }

  Widget _buildPermissionDeniedState(BuildContext context) {
    return Column(
      children: [Text('No se tiene permiso para acceder la ubicación')],
    );
  }

  Widget _buildPermissionDeniedForeverState(BuildContext context) {
    return Column(
      children: [
        Text(
          'Los permisos fueron denegados permanentemente. Habilítalos en Ajustes.',
        ),
        ElevatedButton(
          onPressed: () async {
            await Geolocator.openAppSettings();
          },
          child: Text('Configuración'),
        ),
      ],
    );
  }

  Widget _buildServiceDisabledState(BuildContext context) {
    return Column(children: [Text('Servicio inhabilitado')]);
  }

  Widget _buildLocationErrorState(BuildContext context, String message) {
    return Column(children: [Text('Error: $message')]);
  }

  Widget _buildPublishingState(
    BuildContext context,
    PositionEntity? position,
    LocationFailure? error,
  ) {
    return Column(
      children: [
        Text('Emitiendo posición'),
        if (position != null)
          Text(
            "Lat: ${position.lat.toString()}  Lng: ${position.lng.toString()}",
          ),
        if (error != null)
          Text(
            'Ultimo intento falló, reintentando',
            style: TextStyle(color: Colors.orange),
          ),
      ],
    );
  }
}
