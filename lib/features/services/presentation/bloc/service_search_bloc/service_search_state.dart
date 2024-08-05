part of 'service_search_bloc.dart';

@immutable
sealed class ServiceSearchState {}

final class ServiceSearchInitial extends ServiceSearchState {}

class ServiceSearchCompleted extends ServiceSearchState {
  final List<ServicesModel> services;

  ServiceSearchCompleted(this.services);
}

class ServiceSearchFailed extends ServiceSearchState {}

class ServiceSearchError extends ServiceSearchState {}
