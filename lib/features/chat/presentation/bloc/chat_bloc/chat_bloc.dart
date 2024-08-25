import 'package:fixit/features/chat/data/data_source/firebase_chat_data_source.dart';
import 'package:fixit/features/chat/domain/entities/message.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    FirebaseChatDatasource firebaseChatDatasource = FirebaseChatDatasource();

    on<LoadMessages>((event, emit) async {
      await emit.forEach<List<Message>>(
          firebaseChatDatasource.getMessages(event.conversationId),
          onData: (data) => MessagesLoaded(data),
          onError: (error, stackTrace) => MessageError());
    });
  }

  //   await sendMessage(event.conversationId, event.text);
  // }
}
