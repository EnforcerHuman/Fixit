part of 'service_provider_search_bloc.dart';

@immutable
sealed class ServiceProviderSearchState {}

final class ServiceProviderSearchInitial extends ServiceProviderSearchState {}

final class SearchCompleted extends ServiceProviderSearchState {
  final List<Map<String, dynamic>> providers;

  SearchCompleted(this.providers);
}

final class SearchError extends ServiceProviderSearchState {}

final class SearchNotFound extends ServiceProviderSearchState {}
