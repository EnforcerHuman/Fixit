part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserUpdated extends UserState {}

class UserUpdateFailed extends UserState {}
