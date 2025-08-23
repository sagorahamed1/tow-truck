

class TowTruckModel {
  final String? id;
  final List<double>? coordinates;
  final String? name;
  final String? companyName;
  final String? carImage;
  final double? rating;
  final int? trips;
  final String? distance;
  final int? amount;

  TowTruckModel({
    this.id,
    this.coordinates,
    this.name,
    this.companyName,
    this.carImage,
    this.rating,
    this.trips,
    this.distance,
    this.amount,
  });

  factory TowTruckModel.fromJson(Map<String, dynamic> json) => TowTruckModel(
    id: json["_id"],
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
    name: json["name"],
    companyName: json["companyName"],
    carImage: json["carImage"],
    rating: json["rating"]?.toDouble(),
    trips: json["trips"],
    distance: json["distance"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    "name": name,
    "companyName": companyName,
    "carImage": carImage,
    "rating": rating,
    "trips": trips,
    "distance": distance,
    "amount": amount,
  };
}
