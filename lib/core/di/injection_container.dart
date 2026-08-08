import 'package:bus_tracker_app/core/constants/api_constants.dart';
import 'package:bus_tracker_app/feature/trip_selection/data/datasources/trip_selection_api.dart';
import 'package:bus_tracker_app/feature/trip_selection/data/datasources/trip_selection_remote_data_source.dart';
import 'package:bus_tracker_app/feature/trip_selection/data/repositories/trip_repository_impl.dart';
import 'package:bus_tracker_app/feature/trip_selection/domain/repositories/trip_repository.dart';
import 'package:bus_tracker_app/feature/trip_selection/domain/usecase/get_active_trip.dart';
import 'package:bus_tracker_app/feature/trip_selection/presentation/bloc/trip_selection_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // --- External ---
  sl.registerLazySingleton(() => Dio());


  // --- Features trip_selection ---

  //Data sources
  sl.registerLazySingleton<TripSelectionRemoteDataSource>(
    () => TripSelectionRemoteDataSourceImpl(sl()),
  );

  //Repositories
  sl.registerLazySingleton<TripRepository>(() => TripRepositoryImpl(sl()));

  //Use Case
  sl.registerLazySingleton<GetActiveTrip>(()=> GetActiveTrip(sl()));

  //Retrofit client
  sl.registerLazySingleton<TripSelectionApi>(
    () => TripSelectionApi(sl(), baseUrl: ApiConstants.baseUrl),
  );

  //Bloc
  sl.registerFactory(() => TripSelectionCubit(sl()));

}
