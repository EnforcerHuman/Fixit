part of 'provider_details_bloc.dart';

@immutable
sealed class ProviderDetailsEvent {}

final class GetProviderDetails extends ProviderDetailsEvent {
  final String id;

  GetProviderDetails(this.id);
}
