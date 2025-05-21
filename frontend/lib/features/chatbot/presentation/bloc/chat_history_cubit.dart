import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/chat_message.dart';

class ChatSession {
  final String id;               // uuid v4 hoặc timestamp
  final String title;            // lấy dòng đầu tiên user hỏi
  final List<ChatMessage> log;   // toàn bộ tin nhắn
  ChatSession({required this.id, required this.title, this.log = const []});

  ChatSession copyWith({List<ChatMessage>? log}) =>
      ChatSession(id: id, title: title, log: log ?? this.log);
}

class ChatHistoryState {
  final List<ChatSession> sessions;
  final String? currentId;
  const ChatHistoryState({this.sessions = const [], this.currentId});

  ChatSession? get current {
    if (sessions.isEmpty) return null;             
    return sessions.firstWhere(
      (s) => s.id == currentId,
      orElse: () => sessions.last,                    
    );
  }
//   ChatSession? get current {
//   if (sessions.isEmpty) return null;
//   final idx = sessions.indexWhere((s) => s.id == currentId);
//   return idx == -1 ? sessions.last : sessions[idx];
// }
}


class ChatHistoryCubit extends Cubit<ChatHistoryState> {
  ChatHistoryCubit() : super(const ChatHistoryState()) {
    // khởi tạo 1 phiên trống
    newSession();
  }

  void newSession() {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final s = ChatSession(id: id, title: 'New chat');
    emit(ChatHistoryState(
        sessions: [...state.sessions, s], currentId: id));
  }

  /// thêm tin nhắn vào phiên hiện tại
  void addMessage(ChatMessage m) {
    final cur = state.current;
    if (cur == null) return;
    final updated =
        cur.copyWith(log: [...cur.log, m]);
    final list = state.sessions
        .map((e) => e.id == cur.id ? updated : e)
        .toList();
    emit(ChatHistoryState(sessions: list, currentId: cur.id));
  }

  void switchTo(String id) =>
      emit(ChatHistoryState(sessions: state.sessions, currentId: id));
}
