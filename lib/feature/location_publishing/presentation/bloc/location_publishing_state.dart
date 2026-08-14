part of 'location_publishing_cubit.dart';

sealed class LocationPublishingState extends Equatable {
  const LocationPublishingState();
}

final class InitialState extends LocationPublishingState {
  @override
  List<Object> get props => [];
}

final class PermissionDeniedState extends LocationPublishingState {
  @override
  List<Object?> get props => [];
}

final class PermissionDeniedForeverState extends LocationPublishingState {
  @override
  List<Object?> get props => [];
}

final class ServiceDisabledState extends LocationPublishingState {
  @override
  List<Object?> get props => [];
}

final class LocationErrorState extends LocationPublishingState {
  final String message;

  const LocationErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

final class PublishingState extends LocationPublishingState {
  final PositionEntity? lastPosition;
  final LocationFailure? lastError;

  const PublishingState(this.lastPosition, {this.lastError});

  @override
  List<Object?> get props => [lastPosition, lastError];
}
