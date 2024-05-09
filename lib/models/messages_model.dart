class MessagesModel {
  final String message;
  final DateTime createdAt;
  final String email;

  MessagesModel({
    required this.email,
    required this.createdAt,
    required this.message,
  });

  factory MessagesModel.fromJson(json) {
    return MessagesModel(
      email: json['email'],
      createdAt: json['createdAt'].toDate(),
      message: json['text'],
    );
  }
}
