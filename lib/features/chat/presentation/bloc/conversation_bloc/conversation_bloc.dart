import 'package:bloc/bloc.dart';
import 'package:fixit/features/authentication/data/datasources/auth_local%20_data_service.dart';
import 'package:fixit/features/chat/data/data_source/firebase_chat_data_source.dart';
import 'package:fixit/features/chat/data/models/conversation_model.dart';
import 'package:meta/meta.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final FirebaseChatDatasource firebaseChatDatasource;
  ConversationBloc(this.firebaseChatDatasource) : super(ConversationInitial()) {
    on<LoadConversations>((event, emit) async {
      String userId = await AuthLocalDataService.getUserId();
      await emit.forEach<List<ConversationModel>>(
          firebaseChatDatasource.getConversations(userId),
          onData: (data) {
            return ConversationsLoaded(data);
          },
          onError: (error, stackTrace) => ConversationError(error.toString()));
    });
  }
}
