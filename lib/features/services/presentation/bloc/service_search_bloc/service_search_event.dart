part of 'service_search_bloc.dart';

@immutable
sealed class ServiceSearchEvent {}

class SearchService extends ServiceSearchEvent {
  final String query;

  SearchService(this.query);
}
