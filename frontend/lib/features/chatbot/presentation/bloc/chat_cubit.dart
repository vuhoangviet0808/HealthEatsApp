import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/usecases/send_message.dart';
import 'chat_history_cubit.dart';

class ChatState {
  final List<ChatMessage> messages;
  final bool sending;
  const ChatState({this.messages = const [], this.sending = false});

  ChatState copyWith({List<ChatMessage>? messages, bool? sending}) => ChatState(
        messages: messages ?? this.messages,
        sending: sending ?? this.sending,
      );
}

class ChatCubit extends Cubit<ChatState> {
  final SendMessage _sendText;
  final ChatHistoryCubit _history;
  ChatCubit(this._sendText, this._history) : super(const ChatState());

  /*-------- gửi TEXT --------*/
  Future<void> onUserSubmit(String text) async {
    final content = text.trim();
    if (content.isEmpty) return;

    final userMsg = ChatMessage(text: content, isUser: true);
    _add(userMsg);

    emit(state.copyWith(sending: true));
    try {
      final botMsg = await _sendText(content);
      _add(botMsg);
    } catch (_) {
      _add(const ChatMessage(text: '⚠️  Bot error, try again', isUser: false));
    }
  }

  /*-------- gửi ẢNH --------*/
  Future<void> onUserSendImage(
      File file, Future<ChatMessage> Function(File) api) async {
    final userImg = ChatMessage(text: '[image]', isUser: true, file: file);
    _add(userImg);

    emit(state.copyWith(sending: true));
    try {
      final botMsg = await api(file);     // hàm gọi YOLO
      _add(botMsg);
    } catch (_) {
      _add(const ChatMessage(
          text: '⚠️  Error analysing image', isUser: false));
    }
  }

  /*-------- helper chung --------*/
  void _add(ChatMessage m) {
    final updated = [...state.messages, m];
    emit(state.copyWith(messages: updated, sending: false));
    _history.addMessage(m);               // lưu vào lịch sử
  }
}
