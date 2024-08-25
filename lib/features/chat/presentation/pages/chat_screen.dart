import 'package:fixit/common/common_widgets/cutom_app_bar.dart';
import 'package:fixit/features/chat/data/data_source/firebase_chat_data_source.dart';
import 'package:fixit/features/chat/data/models/conversation_model.dart';
import 'package:fixit/features/chat/data/models/message_model.dart';
import 'package:fixit/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:fixit/features/chat/presentation/widgets/message_list.dart';
import 'package:fixit/features/chat/presentation/widgets/message_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  final String conversationId;
  final ConversationModel conversation1;
  final TextEditingController _messageController = TextEditingController();
  final String currentUser;
  final String providerName;
  final String currentUserName;
  ChatScreen(
      {super.key,
      required this.conversationId,
      required this.conversation1,
      required this.currentUser,
      required this.providerName,
      required this.currentUserName});

  @override
  Widget build(BuildContext context) {
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc.add(LoadMessages(conversationId));
    return Scaffold(
      appBar: CustomAppBar(
        title: providerName,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is MessagesLoaded) {
                  return MessageList(
                      messages: state.messages, currentUserId: currentUser);
                } else if (state is MessageError) {
                  return const Center(child: Text('Error: '));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          MessageTextField(
            messageController: _messageController,
            onPressed: () {
              if (_messageController.text.isNotEmpty) {
                onMessageSend();
                _messageController.clear();
              }
            },
          )
        ],
      ),
    );
  }

  void onMessageSend() {
    MessageModel message = MessageModel(
      id: DateTime.now().toString(),
      senderId: currentUser,
      text: _messageController.text,
      timestamp: DateTime.now(),
    );
    final conversation = ConversationModel(
      providerName: conversation1.providerName,
      userName: conversation1.userName,
      id: conversationId,
      participants: conversation1.participants,
      lastMessage: message,
    );
    FirebaseChatDatasource firebaseChatDatasource = FirebaseChatDatasource();
    firebaseChatDatasource.sendMessage(
        conversation, message, currentUserName, conversation1.providerName);
  }
}
