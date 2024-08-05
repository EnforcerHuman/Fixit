part of 'providers_by_location_bloc.dart';

@immutable
sealed class ProvidersByLocationEvent {}

class GetProviderByLocation extends ProvidersByLocationEvent {
  final double userLatitude;
  final double userLongitude;

  GetProviderByLocation(this.userLatitude, this.userLongitude);
}
