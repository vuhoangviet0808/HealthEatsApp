import 'dart:io';

class ChatMessage {
  final String text;
  final bool isUser;
  final File? file;
  const ChatMessage({required this.text, required this.isUser, this.file});
}