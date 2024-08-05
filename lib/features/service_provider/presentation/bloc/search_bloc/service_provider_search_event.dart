part of 'service_provider_search_bloc.dart';

@immutable
sealed class ServiceProviderSearchEvent {}

class ServiceProviderSearch extends ServiceProviderSearchEvent {
  final String query;

  ServiceProviderSearch(this.query);
}
