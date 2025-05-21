import '../entities/chat_message.dart';
import '../repositories/chat_repository.dart';

class SendMessage {
  final ChatRepository repo;
  SendMessage(this.repo);

  Future<ChatMessage> call(String prompt) => repo.send(prompt);
}