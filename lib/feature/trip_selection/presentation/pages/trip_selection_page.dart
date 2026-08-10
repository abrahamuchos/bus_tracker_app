import 'package:bus_tracker_app/feature/trip_selection/domain/entities/trip.dart';
import 'package:bus_tracker_app/feature/trip_selection/presentation/bloc/trip_selection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bus_tracker_app/core/di/injection_container.dart';

class TripSelectionPage extends StatelessWidget {
  const TripSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trip Selection')),
      body: BlocProvider<TripSelectionCubit>(
        create: (context) => sl<TripSelectionCubit>()..fetchActiveTrip(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              BlocBuilder<TripSelectionCubit, TripSelectionState>(
                builder: (context, state) {
                  return switch (state) {
                    TripSelectionLoading() => Center(
                      child: const CircularProgressIndicator(),
                    ),
                    TripSelectionLoaded(:final trip) => _buildInfoCard(trip),
                    TripSelectionNoActiveTrip() => const Text(
                      'Not active trip yet.',
                    ),
                    TripSelectionError(:final message) => Center(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  };
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(TripEntity trip) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Id: ${trip.id}'),
        Text('Bus plate: ${trip.busPlate}'),
        Text('Status: ${trip.status.label}'),
        Text('Route: ${trip.route?.name}'),
      ],
    );
  }
}
