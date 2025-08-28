

class ChatModel {
  final String? id;
  final String? senderId;
  final String? content;
  final List<dynamic>? attachments;
  final List<dynamic>? receivedBy;
  final List<dynamic>? readBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? threadId;

  ChatModel({
    this.id,
    this.senderId,
    this.content,
    this.attachments,
    this.receivedBy,
    this.readBy,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.threadId,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    id: json["_id"],
    senderId: json["senderId"],
    content: json["content"],
    attachments: json["attachments"] == null ? [] : List<dynamic>.from(json["attachments"]!.map((x) => x)),
    receivedBy: json["receivedBy"] == null ? [] : List<dynamic>.from(json["receivedBy"]!.map((x) => x)),
    readBy: json["readBy"] == null ? [] : List<dynamic>.from(json["readBy"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    threadId: json["threadId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "senderId": senderId,
    "content": content,
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x)),
    "receivedBy": receivedBy == null ? [] : List<dynamic>.from(receivedBy!.map((x) => x)),
    "readBy": readBy == null ? [] : List<dynamic>.from(readBy!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "threadId": threadId,
  };
}
