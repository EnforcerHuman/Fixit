part of 'profession_specific_bloc.dart';

@immutable
abstract class ProfessionSpecificState {}

class ProfessionSpecificInitial extends ProfessionSpecificState {}

class ProfessionSpecificLoading extends ProfessionSpecificState {}

class ProfessionSpecificLoaded extends ProfessionSpecificState {
  final List<Map<String, dynamic>> providers;

  ProfessionSpecificLoaded(this.providers);
}

class ProfessionSpecificError extends ProfessionSpecificState {
  final String message;

  ProfessionSpecificError(this.message);
}
