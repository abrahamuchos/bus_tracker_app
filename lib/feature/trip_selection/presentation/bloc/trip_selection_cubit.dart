import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bus_tracker_app/core/usecase/usecase.dart';
import 'package:bus_tracker_app/feature/trip_selection/domain/entities/trip.dart';
import 'package:bus_tracker_app/feature/trip_selection/domain/usecase/get_active_trip.dart';
import 'package:equatable/equatable.dart';

part 'trip_selection_state.dart';

class TripSelectionCubit extends Cubit<TripSelectionState> {
  final GetActiveTrip _getActiveTrip;

  TripSelectionCubit(this._getActiveTrip) : super(TripSelectionLoading());

  Future<void> fetchActiveTrip() async {
    emit(TripSelectionLoading());

    final result = await _getActiveTrip(const NoParams());

    result.fold(
      (failure) => emit(TripSelectionError(failure.message)),
      (trip){
        if(trip == null){
          emit(TripSelectionNoActiveTrip());
        }else{
          emit(TripSelectionLoaded(trip));
        }
      },
    );
  }
}
