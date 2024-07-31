part of 'services_bloc.dart';

@immutable
sealed class ServicesEvent {}

class GetServices extends ServicesEvent {}
