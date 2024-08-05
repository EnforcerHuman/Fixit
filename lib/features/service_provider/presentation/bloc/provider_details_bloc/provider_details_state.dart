part of 'provider_details_bloc.dart';

@immutable
sealed class ProviderDetailsState {}

final class ProviderDetailsInitial extends ProviderDetailsState {}

final class ProviderDetailsLoaded extends ProviderDetailsState {
  final Map<String, dynamic> providerDetails;

  ProviderDetailsLoaded(this.providerDetails);
}

final class ProviderDetailsLoading extends ProviderDetailsState {}

final class ProviderDetailsError extends ProviderDetailsState {}
