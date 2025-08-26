

class UserJobRequestModel {
  final String? jobId;
  final String? userId;
  final String? userProfile;
  final String? userName;
  final int? amount;
  final double? avgRating;
  final int? totalRating;
  final String? distance;
  final String? fromAddress;
  final String? toAddress;
  final String? vehicle;
  final String? issue;
  final String? note;
  final String? status;

  UserJobRequestModel({
    this.jobId,
    this.userId,
    this.userProfile,
    this.userName,
    this.amount,
    this.avgRating,
    this.totalRating,
    this.distance,
    this.fromAddress,
    this.toAddress,
    this.vehicle,
    this.issue,
    this.note,
    this.status,
  });

  factory UserJobRequestModel.fromJson(Map<String, dynamic> json) => UserJobRequestModel(
    jobId: json["jobId"],
    userId: json["userId"],
    userProfile: json["userProfile"],
    userName: json["userName"],
    amount: json["amount"],
    avgRating: json["avgRating"]?.toDouble(),
    totalRating: json["totalRating"],
    distance: json["distance"],
    fromAddress: json["fromAddress"],
    toAddress: json["toAddress"],
    vehicle: json["vehicle"],
    issue: json["issue"],
    note: json["note"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "jobId": jobId,
    "userId": userId,
    "userProfile": userProfile,
    "userName": userName,
    "amount": amount,
    "avgRating": avgRating,
    "totalRating": totalRating,
    "distance": distance,
    "fromAddress": fromAddress,
    "toAddress": toAddress,
    "vehicle": vehicle,
    "issue": issue,
    "note": note,
    "status": status,
  };
}
