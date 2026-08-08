part of 'trip_selection_cubit.dart';

sealed class TripSelectionState extends Equatable {
  const TripSelectionState();
}

final class TripSelectionInitial extends TripSelectionState {
  @override
  List<Object> get props => [];
}
