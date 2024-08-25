import 'package:fixit/features/chat/domain/entities/message.dart';
import 'package:fixit/features/chat/presentation/widgets/date_header.dart';
import 'package:fixit/features/chat/presentation/widgets/message_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageList extends StatelessWidget {
  final List<Message> messages;
  final String currentUserId;

  const MessageList({
    super.key,
    required this.messages,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    // Group messages by date
    Map<DateTime, List<Message>> groupedMessages = {};
    for (var message in messages) {
      final messageDate = DateTime(
        message.timestamp.year,
        message.timestamp.month,
        message.timestamp.day,
      );
      if (!groupedMessages.containsKey(messageDate)) {
        groupedMessages[messageDate] = [];
      }
      groupedMessages[messageDate]!.add(message);
    }

    // Create a list of date headers with messages under them
    final groupedMessagesList = groupedMessages.entries.toList();

    return ListView.builder(
      reverse: true,
      itemCount: groupedMessagesList.length,
      itemBuilder: (context, index) {
        final entry = groupedMessagesList[index];
        final date = entry.key;
        final messages =
            entry.value.reversed.toList(); // Reverse the order of messages

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DateHeader(date: DateFormat.yMMMd().format(date)),
            ...messages.map((message) {
              final isSentByCurrentUser = message.senderId == currentUserId;
              final formattedTime =
                  DateFormat.jm().format(message.timestamp); // Format the time

              return Align(
                alignment: isSentByCurrentUser
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: MessageField(
                    isSentByCurrentUser: isSentByCurrentUser,
                    message: message.text,
                    time: formattedTime),
              );
              // ignore: unnecessary_to_list_in_spreads
            }).toList(),
          ],
        );
      },
    );
  }
}
