import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/chat_cubit.dart';
import '../bloc/chat_history_cubit.dart';
import '../../data/datasources/chat_remote_ds.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/usecases/send_message.dart';
import '../../../../core/themes/theme.dart';
import '../../domain/entities/chat_message.dart';   // dùng để tạo msg ảnh

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ChatHistoryCubit()),
        BlocProvider(
          create: (ctx) => ChatCubit(
            SendMessage(ChatRepositoryImpl(ChatRemoteDS())),
            ctx.read<ChatHistoryCubit>(),
          ),
        ),
      ],
      child: const _ChatScaffold(),
    );
  }
}

/*==================== SCAFFOLD + DRAWER ====================*/
class _ChatScaffold extends StatelessWidget {
  const _ChatScaffold();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatHistoryCubit, ChatHistoryState>(
      builder: (ctx, hState) => Scaffold(
        appBar: AppBar(title: const Text('Chatbot')),
        drawer: Drawer(
          width: 260,
          child: SafeArea(
            child: Column(
              children: [
                DrawerHeader(
                  child: Image.asset('assets/images/logo2.webp'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: hState.sessions.length,
                    itemBuilder: (_, i) {
                      final s = hState.sessions[i];
                      final sel = s.id == hState.currentId;
                      return ListTile(
                        dense: true,
                        selected: sel,
                        title: Text(
                          s.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          ctx.read<ChatHistoryCubit>().switchTo(s.id);
                          Navigator.pop(ctx);
                        },
                      );
                    },
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('New chat'),
                  onTap: () {
                    ctx.read<ChatHistoryCubit>().newSession();
                    Navigator.pop(ctx);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {}, // TODO
                ),
              ],
            ),
          ),
        ),
        body: const _ChatBody(),
      ),
    );
  }
}

/*============================= BODY =============================*/
class _ChatBody extends StatefulWidget {
  const _ChatBody();

  @override
  State<_ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<_ChatBody> {
  final _textC   = TextEditingController();
  final _scrollC = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*----------- LIST MESSAGE -----------*/
        Expanded(
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (ctx, state) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_scrollC.hasClients) {
                  _scrollC.jumpTo(_scrollC.position.maxScrollExtent);
                }
              });
              return ListView.builder(
                controller: _scrollC,
                padding: const EdgeInsets.all(12),
                itemCount: state.messages.length,
                itemBuilder: (_, i) {
                  final m = state.messages[i];
                  return _bubble(m);
                },
              );
            },
          ),
        ),
        /*----------- INPUT ROW -----------*/
        _inputRow(),
      ],
    );
  }

  /*=========== bubble (text hoặc ảnh) ===========*/
  Widget _bubble(ChatMessage m) {
    final align =
        m.isUser ? Alignment.centerRight : Alignment.centerLeft;

    // Ảnh của user
    if (m.file != null) {
      return Align(
        alignment: align,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Image.file(m.file!, width: 180),
        ),
      );
    }

    final color =
        m.isUser ? primaryColor.withOpacity(.15) : Colors.white;
    return Align(
      alignment: align,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(m.text),
      ),
    );
  }

  /*=========== input row ===========*/
  Widget _inputRow() => SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: _pickImage,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: TextField(
                  controller: _textC,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _sendText(),
                  decoration:
                      const InputDecoration(hintText: 'Ask me anything...'),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: _sendText,
            ),
          ],
        ),
      );

  /*=========== send text ===========*/
  void _sendText() {
    final txt = _textC.text;
    _textC.clear();
    context.read<ChatCubit>().onUserSubmit(txt);
  }

  /*=========== pick & send image ===========*/
  Future<void> _pickImage() async {
    final x =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (x == null) return;

    final file = File(x.path);

    // Callback gửi ảnh tới Cubit; truyền hàm gọi API YOLO
    context.read<ChatCubit>().onUserSendImage(
      file,
      (f) async {
        final bot = await ChatRemoteDS().sendImage(f);
        return ChatMessage(text: bot.text, isUser: false);
      },
    );
  }
}
