

class JobDetailsModel {
  final String? jobId;
  final String? providerId;
  final String? providerName;
  final String? profileImage;
  final String? phone;
  final String? email;
  final String? address;
  final String? carImage;
  final String? companyName;
  final String? towType;
  final String? description;
  final int? totalRating;
  final bool? isVerified;
  final dynamic fromAddress;
  final dynamic toAddress;
  final List<Promo>? promos;
  final String? distance;
  final int? amount;
  final int? charge;
  final int? discount;
  final int? minAmount;
  final int? negAmount;

  JobDetailsModel({
    this.jobId,
    this.providerId,
    this.providerName,
    this.profileImage,
    this.phone,
    this.email,
    this.address,
    this.carImage,
    this.companyName,
    this.towType,
    this.description,
    this.totalRating,
    this.isVerified,
    this.fromAddress,
    this.toAddress,
    this.promos,
    this.distance,
    this.amount,
    this.charge,
    this.discount,
    this.minAmount,
    this.negAmount,
  });

  factory JobDetailsModel.fromJson(Map<String, dynamic> json) => JobDetailsModel(
    jobId: json["jobId"],
    providerId: json["providerId"],
    providerName: json["providerName"],
    profileImage: json["profileImage"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
    carImage: json["carImage"],
    companyName: json["companyName"],
    towType: json["towType"],
    description: json["description"],
    totalRating: json["totalRating"],
    isVerified: json["isVerified"],
    fromAddress: json["fromAddress"],
    toAddress: json["toAddress"],
    promos: json["promos"] == null ? [] : List<Promo>.from(json["promos"]!.map((x) => Promo.fromJson(x))),
    distance: json["distance"],
    amount: json["amount"],
    charge: json["charge"],
    discount: json["discount"],
    minAmount: json["minAmount"],
    negAmount: json["negAmount"],
  );

  Map<String, dynamic> toJson() => {
    "jobId": jobId,
    "providerId": providerId,
    "providerName": providerName,
    "profileImage": profileImage,
    "phone": phone,
    "email": email,
    "address": address,
    "carImage": carImage,
    "companyName": companyName,
    "towType": towType,
    "description": description,
    "totalRating": totalRating,
    "isVerified": isVerified,
    "fromAddress": fromAddress,
    "toAddress": toAddress,
    "promos": promos == null ? [] : List<dynamic>.from(promos!.map((x) => x.toJson())),
    "distance": distance,
    "amount": amount,
    "charge": charge,
    "discount": discount,
    "minAmount": minAmount,
    "negAmount": negAmount,
  };
}

class Promo {
  final String? id;
  final String? code;
  final String? type;
  final int? value;
  final DateTime? expireDate;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Promo({
    this.id,
    this.code,
    this.type,
    this.value,
    this.expireDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Promo.fromJson(Map<String, dynamic> json) => Promo(
    id: json["_id"],
    code: json["code"],
    type: json["type"],
    value: json["value"],
    expireDate: json["expireDate"] == null ? null : DateTime.parse(json["expireDate"]),
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "code": code,
    "type": type,
    "value": value,
    "expireDate": expireDate?.toIso8601String(),
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
