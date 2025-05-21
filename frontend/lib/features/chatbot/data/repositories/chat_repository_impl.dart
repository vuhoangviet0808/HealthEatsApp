import 'dart:io';

import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_ds.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDS _ds;
  ChatRepositoryImpl(this._ds);

  /*----------- Send Text -----------*/
  @override
  Future<ChatMessage> send(String prompt) async {
    final model = await _ds.sendText(prompt);
    // model.isUser luôn false (bot trả lời)
    return ChatMessage(text: model.text, isUser: model.isUser);
  }

  /*----------- Send Image -----------*/
  Future<ChatMessage> sendImage(File file) async {
    final model = await _ds.sendImage(file);
    return ChatMessage(text: model.text, isUser: model.isUser);
  }
}
