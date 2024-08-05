part of 'single_service_provider_bloc.dart';

@immutable
sealed class SingleServiceProviderEvent {}

class GetSingleServiceProvider extends SingleServiceProviderEvent {
  final String userId;

  GetSingleServiceProvider(this.userId);
}
