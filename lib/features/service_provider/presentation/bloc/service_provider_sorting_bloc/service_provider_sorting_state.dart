part of 'service_provider_sorting_bloc.dart';

@immutable
sealed class ServiceProviderSortingState {}

final class ServiceProviderSortingInitial extends ServiceProviderSortingState {}

class ServiceProviderSorted extends ServiceProviderSortingState {
  final List<Map<String, dynamic>> sortedProviders;

  ServiceProviderSorted(this.sortedProviders);
}

class ServiceProviderSortingError extends ServiceProviderSortingState {
  final String error;

  ServiceProviderSortingError(this.error);
}
