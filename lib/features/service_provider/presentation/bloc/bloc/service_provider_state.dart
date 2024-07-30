part of 'service_provider_bloc.dart';

@immutable
sealed class ServiceProviderState {}

final class ServiceProviderInitial extends ServiceProviderState {}

class ServiceProviderLoading extends ServiceProviderState {}

class ServiceProviderLoaded extends ServiceProviderState {
  final List<Map<String, dynamic>> providers;

  ServiceProviderLoaded(this.providers);
}

class ServiceProviderError extends ServiceProviderState {
  final String error;

  ServiceProviderError(this.error);
}
