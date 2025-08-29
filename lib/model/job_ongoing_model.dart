

class JobOngoingModel {
  final String? jobId;
  final String? userId;
  final String? name;
  final num? negAmount;
  final String? email;
  final String? phone;
  final String? profileImage;
  final String? description;
  final String? fromAddress;
  final String? driverImage;
  final String? toAddress;
  final String? carImage;
  final double? distance;
  final List<double>? coordinate;
  final List<double>? destCoordinate;
  final String? note;
  final String? status;
  final DateTime? date;

  JobOngoingModel({
    this.jobId,
    this.userId,
    this.name,
    this.negAmount,
    this.email,
    this.phone,
    this.profileImage,
    this.description,
    this.fromAddress,
    this.driverImage,
    this.toAddress,
    this.carImage,
    this.distance,
    this.coordinate,
    this.destCoordinate,
    this.note,
    this.status,
    this.date,
  });

  factory JobOngoingModel.fromJson(Map<String, dynamic> json) => JobOngoingModel(
    jobId: json["jobId"],
    userId: json["userId"],
    name: json["name"],
    negAmount: json["negAmount"],
    email: json["email"],
    phone: json["phone"],
    profileImage: json["profileImage"],
    description: json["description"],
    fromAddress: json["fromAddress"],
    driverImage: json["driverImage"],
    toAddress: json["toAddress"],
    carImage: json["carImage"],
    distance: json["distance"]?.toDouble(),
    coordinate: json["coordinate"] == null ? [] : List<double>.from(json["coordinate"]!.map((x) => x?.toDouble())),
    destCoordinate: json["destCoordinate"] == null ? [] : List<double>.from(json["destCoordinate"]!.map((x) => x?.toDouble())),
    note: json["note"],
    status: json["status"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "jobId": jobId,
    "userId": userId,
    "name": name,
    "negAmount": negAmount,
    "email": email,
    "phone": phone,
    "profileImage": profileImage,
    "description": description,
    "fromAddress": fromAddress,
    "driverImage": driverImage,
    "toAddress": toAddress,
    "carImage": carImage,
    "distance": distance,
    "coordinate": coordinate == null ? [] : List<dynamic>.from(coordinate!.map((x) => x)),
    "destCoordinate": destCoordinate == null ? [] : List<dynamic>.from(destCoordinate!.map((x) => x)),
    "note": note,
    "status": status,
    "date": date?.toIso8601String(),
  };
}
