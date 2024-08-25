part of 'conversation_bloc.dart';

@immutable
sealed class ConversationState {}

final class ConversationInitial extends ConversationState {}

class ConversationsLoaded extends ConversationState {
  // final Stream<List<Conversation>> conversations;
  final List<ConversationModel> conversations;
  ConversationsLoaded(this.conversations);
}

class ConversationError extends ConversationState {
  final String error;

  ConversationError(this.error);
}
