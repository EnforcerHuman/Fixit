part of 'single_service_provider_bloc.dart';

@immutable
sealed class SingleServiceProviderState {}

final class SingleServiceProviderInitial extends SingleServiceProviderState {}

class SingleServiceProviderLoaded extends SingleServiceProviderState {}

class SingleServiceProviderLoading extends SingleServiceProviderState {}

class SingleServiceProviderError extends SingleServiceProviderState {}
