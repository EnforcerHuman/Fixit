part of 'provider_stats_bloc.dart';

sealed class ProviderStatsState {}

class ProviderStatsInitial extends ProviderStatsState {}

class ProviderStatsLoaded extends ProviderStatsState {
  final int count;

  ProviderStatsLoaded(this.count);
}

final class ProiderStatsError extends ProviderStatsState {}

class ProiderStatsLoading extends ProviderStatsState {}
