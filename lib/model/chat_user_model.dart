

class ChatUserModel {
  final String? id;
  final int? unreadCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final LastMessage? lastMessage;
  final Receiver? receiver;

  ChatUserModel({
    this.id,
    this.unreadCount,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.lastMessage,
    this.receiver,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) => ChatUserModel(
    id: json["_id"],
    unreadCount: json["unreadCount"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? DateTime.now() : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
    receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "unreadCount": unreadCount,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "lastMessage": lastMessage?.toJson(),
    "receiver": receiver?.toJson(),
  };
}

class LastMessage {
  final String? content;
  final DateTime? createdAt;

  LastMessage({
    this.content,
    this.createdAt,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    content: json["content"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "createdAt": createdAt?.toIso8601String(),
  };
}

class Receiver {
  final String? id;
  final String? name;
  final String? profileImage;
  final String? receiverId;
  final bool? isOnline;

  Receiver({
    this.id,
    this.name,
    this.profileImage,
    this.receiverId,
    this.isOnline,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
    id: json["_id"],
    name: json["name"],
    profileImage: json["profileImage"],
    receiverId: json["id"],
    isOnline: json["isOnline"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "profileImage": profileImage,
    "id": receiverId,
    "isOnline": isOnline,
  };
}
