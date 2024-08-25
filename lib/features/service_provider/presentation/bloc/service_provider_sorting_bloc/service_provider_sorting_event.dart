part of 'service_provider_sorting_bloc.dart';

@immutable
sealed class ServiceProviderSortingEvent {}

class ServiceProviderSortRequested extends ServiceProviderSortingEvent {
  final String sortingCriteria;
  final List<Map<String, dynamic>> providers;
  ServiceProviderSortRequested(this.sortingCriteria, this.providers);
}
