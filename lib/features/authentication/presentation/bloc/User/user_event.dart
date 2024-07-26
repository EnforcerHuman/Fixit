part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class UpdateName extends UserEvent {
  final String name;

  UpdateName(this.name);
}

class UpdatePhone extends UserEvent {
  final String phone;

  UpdatePhone(this.phone);
}

class UpdateEmail extends UserEvent {
  final String email;

  UpdateEmail(this.email);
}

class UpdateUserId extends UserEvent {
  final String userId;

  UpdateUserId(this.userId);
}

class SubmitUserDate extends UserEvent {}

class UpdateIsServiceProvider extends UserEvent {
  final bool isServiceProvider;

  UpdateIsServiceProvider(this.isServiceProvider);
}
