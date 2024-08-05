part of 'providers_by_location_bloc.dart';

@immutable
sealed class ProvidersByLocationState {}

final class ProvidersByLocationInitial extends ProvidersByLocationState {}

class ProvidersByLocationLoaded extends ProvidersByLocationState {
  final List<Map<String, dynamic>> providers;

  ProvidersByLocationLoaded(this.providers);
}

class GetProvidersByLocationLoading extends ProvidersByLocationState {}

class GetProvidersByLocationError extends ProvidersByLocationState {}

class GetProvidersByLocationFailed extends ProvidersByLocationState {}
