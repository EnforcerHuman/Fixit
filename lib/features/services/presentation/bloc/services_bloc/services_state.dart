part of 'services_bloc.dart';

@immutable
sealed class ServicesState {}

final class ServicesInitial extends ServicesState {}

final class ServicesLoading extends ServicesState {}

final class ServicesLoaded extends ServicesState {
  final List<Service> services;

  ServicesLoaded(this.services);
}

final class ServicesError extends ServicesState {
  final String error;

  ServicesError(this.error);
}
