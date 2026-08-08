import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'trip_selection_state.dart';

class TripSelectionCubit extends Cubit<TripSelectionState> {
  TripSelectionCubit() : super(TripSelectionInitial());
}
