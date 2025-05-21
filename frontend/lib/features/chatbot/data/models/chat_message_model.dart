class ChatMessageModel {
  final String text;
  final bool isUser;
  const ChatMessageModel(this.text, this.isUser);

  factory ChatMessageModel.fromJson(Map<String, dynamic> j) =>
      ChatMessageModel(j['text'] as String, j['role'] == 'user');

  Map<String, dynamic> toJson() =>
      {'text': text, 'role': isUser ? 'user' : 'bot'};
}
