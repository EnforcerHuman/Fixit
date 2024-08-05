part of 'profession_specific_bloc.dart';

@immutable
sealed class ProfessionSpecificEvent {}

class FetchProvidersByProfession extends ProfessionSpecificEvent {
  final String query;

  FetchProvidersByProfession(this.query);
}
