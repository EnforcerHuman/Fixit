part of 'conversation_bloc.dart';

@immutable
sealed class ConversationEvent {}

class LoadConversations extends ConversationEvent {}
