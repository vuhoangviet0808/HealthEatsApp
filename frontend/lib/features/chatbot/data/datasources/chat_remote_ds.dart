import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/chat_message_model.dart';

class ChatRemoteDS {
  static const _url = 'https://your-api/chat'; 

  Future<ChatMessageModel> send(String prompt) async {
    final res = await http
        .post(Uri.parse(_url), body: jsonEncode({'prompt': prompt}), headers: {
      'Content-Type': 'application/json',
    });

    if (res.statusCode == 200) {
      // Giả sử backend trả {"text": "...", "role": "bot"}
      return ChatMessageModel.fromJson(jsonDecode(res.body));
    }
    throw Exception('Chat API error ${res.statusCode}');
  }

  sendImage(File f) {}
}
