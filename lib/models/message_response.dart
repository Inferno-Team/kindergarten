class Message {
  final String text;
  DateTime createdAt;
  Message({required this.text, required this.createdAt});
  factory Message.fromJson(dynamic json) => Message(
      text: json['message_text'] ?? json['title'] ?? "",
      createdAt: DateTime.parse(
        json['created_at'],
      ));
  Map<String, dynamic> toMap() {
    return {'title': text, 'created_at': createdAt.toIso8601String()};
  }
}

class MessageType {
  final String type;
  final List<Message> messages;

  MessageType({required this.type, required this.messages});
  factory MessageType.fromJson(dynamic json) {
    return MessageType(
        type: json['type'],
        messages: (json['messages'] as List<dynamic>)
            .map((e) => Message.fromJson(e))
            .toList());
  }
}

class MessageResponse {
  final bool status;
  final String errorNumber;
  final String message;
  final List<MessageType> messages;

  MessageResponse(
      {this.status = false,
      this.errorNumber = '',
      this.message = '',
      required this.messages});
  factory MessageResponse.fromJson(dynamic json) {
    var status = json['status'] ?? false;
    var errorNumber = json['errNum'] ?? -1;
    var msg = json['msg'] ?? '';
    var messages = (json['message'] as List<dynamic>);
    var msgs = <MessageType>[];
    for (var msg in messages) {
      final type = MessageType.fromJson(msg);
      msgs.add(type);
    }

    return MessageResponse(
        errorNumber: errorNumber, status: status, message: msg, messages: msgs);
  }
}
