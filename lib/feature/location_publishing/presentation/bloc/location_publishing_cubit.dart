import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bus_tracker_app/core/usecase/usecase.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/entities/position.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/error/location_failure.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/repositories/location_repository.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/usecase/check_location_enabled.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/usecase/get_current_position.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/usecase/request_location_permission.dart';
import 'package:bus_tracker_app/feature/location_publishing/domain/usecase/update_bus_location.dart';
import 'package:equatable/equatable.dart';

part 'location_publishing_state.dart';

class LocationPublishingCubit extends Cubit<LocationPublishingState> {
  final RequestLocationPermission requestLocationPermission;
  final CheckLocationEnabled checkLocationEnabled;
  final GetCurrentPosition getCurrentPosition;
  final UpdateBusLocation updateBusLocation;

  Timer? _timer;
  int? _tripId;

  LocationPublishingCubit({
    required this.requestLocationPermission,
    required this.checkLocationEnabled,
    required this.getCurrentPosition,
    required this.updateBusLocation,
  }) : super(InitialState());

  Future<void> startPublishing(int tripId) async {
    _timer?.cancel();

    final serviceEnabledResult = await checkLocationEnabled(const NoParams());
    final serviceEnabled = serviceEnabledResult.fold(
      (_) => false,
      (v) => v ?? false,
    );

    if (!serviceEnabled) {
      emit(ServiceDisabledState());
      return;
    }

    final permissionRequest = await requestLocationPermission(const NoParams());

    permissionRequest.fold(
      (failure) => emit(LocationErrorState(failure.message)),
      (permission) async {
        switch (permission) {
          case PermissionRequestResult.granted:
            _tripId = tripId;
            await _publishTick();
            _timer = Timer.periodic(
              const Duration(seconds: 15),
              (_) => _publishTick(),
            );
            break;
          case PermissionRequestResult.denied:
            emit(PermissionDeniedState());
            break;
          case PermissionRequestResult.deniedForever:
            emit(PermissionDeniedForeverState());
            break;
          case null:
            emit(LocationErrorState('Error to location'));
            break;
        }
      },
    );
  }

  Future<void> _publishTick() async {
    final positionResult = await getCurrentPosition(const NoParams());

    positionResult.fold(
      (failure) {
        //El error es silencioso no detiene la UI
        final previousPosition =
            (state is PublishingState)
                ? (state as PublishingState).lastPosition
                : null;

        emit(
          PublishingState(
            previousPosition,
            lastError: LocationFailure(
              LocationFailureType.positionUnavailable,
              failure.message,
            ),
          ),
        );
      },
      (position) {
        updateBusLocation(
          UpdateBusLocationParams(tripId: _tripId!, position: position!),
        );
        emit(PublishingState(position));
      },
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
