part of 'provider_stats_bloc.dart';

@immutable
sealed class ProviderStatsEvent {}

final class GetProviderStats extends ProviderStatsEvent {
  final String id;

  GetProviderStats(this.id);
}
