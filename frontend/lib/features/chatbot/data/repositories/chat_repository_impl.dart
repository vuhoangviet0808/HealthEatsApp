import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_ds.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDS ds;
  ChatRepositoryImpl(this.ds);

  @override
  Future<ChatMessage> send(String prompt) async {
    final m = await ds.send(prompt);
    return ChatMessage(text: m.text, isUser: m.isUser, file: null);
  }
}
