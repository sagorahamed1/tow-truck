

class PaymentHistoryModel {
  final String? trId;
  final DateTime? createdAt;
  final int? amount;
  final String? title;
  final String? image;
  final String? status;

  PaymentHistoryModel({
    this.trId,
    this.createdAt,
    this.amount,
    this.title,
    this.image,
    this.status,
  });

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) => PaymentHistoryModel(
    trId: json["trId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    amount: json["amount"],
    title: json["title"],
    image: json["image"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "trId": trId,
    "createdAt": createdAt?.toIso8601String(),
    "amount": amount,
    "title": title,
    "image": image,
    "status": status,
  };
}
