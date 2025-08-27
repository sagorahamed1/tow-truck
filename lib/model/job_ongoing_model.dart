

class JobOngoingModel {
  final String? jobId;
  final String? userId;
  final String? name;
  final String? profileImage;
  final String? fromAddress;
  final String? toAddress;
  final List<double>? coordinate;
  final List<double>? destCoordinate;
  final String? note;
  final String? status;
  final DateTime? date;

  JobOngoingModel({
    this.jobId,
    this.userId,
    this.name,
    this.profileImage,
    this.fromAddress,
    this.toAddress,
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
    profileImage: json["profileImage"],
    fromAddress: json["fromAddress"],
    toAddress: json["toAddress"],
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
    "profileImage": profileImage,
    "fromAddress": fromAddress,
    "toAddress": toAddress,
    "coordinate": coordinate == null ? [] : List<dynamic>.from(coordinate!.map((x) => x)),
    "destCoordinate": destCoordinate == null ? [] : List<dynamic>.from(destCoordinate!.map((x) => x)),
    "note": note,
    "status": status,
    "date": date?.toIso8601String(),
  };
}
