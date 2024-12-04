enum UserChat { userMe, userYou }

class ChatMessage {
  final String text;
  final UserChat userChat;

  ChatMessage({
    required this.text,
    required this.userChat,
  });
}