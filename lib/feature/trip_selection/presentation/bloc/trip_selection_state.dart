part of 'trip_selection_cubit.dart';

sealed class TripSelectionState extends Equatable {
  const TripSelectionState();
}

final class TripSelectionLoading extends TripSelectionState {
  @override
  List<Object?> get props => [];
}

final class TripSelectionLoaded extends TripSelectionState {
  final TripEntity trip;

  const TripSelectionLoaded(this.trip);

  @override
  List<Object?> get props => [trip];
}

final class TripSelectionNoActiveTrip extends TripSelectionState {
  @override
  List<Object?> get props => [];
}

final class TripSelectionError extends TripSelectionState {
  final String message;

  const TripSelectionError(this.message);

  @override
  List<Object?> get props => [message];
}
