import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../models/chat_message_model.dart';

class ChatRemoteDS {
  static const _textUrl  = 'http://10.0.2.2:8000/chat/text';
  static const _imageUrl = 'http://10.0.2.2:8000/chat/image';

  /*----------- gửi văn bản -----------*/
  Future<ChatMessageModel> sendText(String prompt) async {
    final res = await http.post(
      Uri.parse(_textUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'prompt': prompt}),
    );
    if (res.statusCode == 200) {
      return ChatMessageModel.fromJson(jsonDecode(res.body));
    }
    throw Exception('Chat API error ${res.statusCode}');
  }

  /*----------- gửi ảnh (YOLO) -----------*/
  Future<ChatMessageModel> sendImage(File file) async {
    final req = http.MultipartRequest('POST', Uri.parse(_imageUrl));

    final mime = lookupMimeType(file.path) ?? 'image/jpeg';
    final media = MediaType.parse(mime);

    req.files.add(await http.MultipartFile.fromPath('file', file.path,
        contentType: media));

    final streamed = await req.send();
    final body = await streamed.stream.bytesToString();

    if (streamed.statusCode == 200) {
      // Giả sử backend trả: {"text": "...", "role":"bot"}
      return ChatMessageModel.fromJson(jsonDecode(body));
    }
    throw Exception('YOLO error ${streamed.statusCode}');
  }
}
