part of 'service_provider_bloc.dart';

@immutable
sealed class ServiceProviderEvent {}

class GetServiceProvider extends ServiceProviderEvent {}
