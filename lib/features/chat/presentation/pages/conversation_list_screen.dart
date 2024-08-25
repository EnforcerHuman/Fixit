import 'package:fixit/common/common_widgets/cutom_app_bar.dart';
import 'package:fixit/features/authentication/data/datasources/auth_local%20_data_service.dart';
import 'package:fixit/features/chat/data/models/conversation_model.dart';
import 'package:fixit/features/chat/presentation/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'chat_screen.dart';

class ConversationListScreen extends StatelessWidget {
  const ConversationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ConversationBloc>().add(LoadConversations());
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Conversations',
      ),
      body: BlocBuilder<ConversationBloc, ConversationState>(
        builder: (context, state) {
          if (state is ConversationsLoaded) {
            if (state.conversations.isEmpty) {
              return const Center(
                child: Text('NO CONVERSATIONS'),
              );
            } else {
              return _builConversation(state);
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _builConversation(ConversationsLoaded state) {
    return ListView.builder(
      itemCount: state.conversations.length,
      itemBuilder: (context, index) {
        final conversation = state.conversations[index];
        final formattedTime =
            DateFormat.jm().format(conversation.lastMessage.timestamp);
        return ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.person_2_outlined),
          ),
          title: Text(conversation.providerName),
          subtitle: Text(conversation.lastMessage.text),
          trailing: Text(formattedTime),
          onTap: () async {
            onClicked(context, conversation);
          },
        );
      },
    );
  }

  void onClicked(BuildContext context, ConversationModel conversation) async {
    String userId = await AuthLocalDataService.getUserId();
    // ignore: use_build_context_synchronously
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          conversationId: conversation.id,
          conversation1: conversation,
          currentUser: userId,
          providerName: conversation.providerName,
          currentUserName: conversation.userName,
        ),
      ),
    );
  }
}
