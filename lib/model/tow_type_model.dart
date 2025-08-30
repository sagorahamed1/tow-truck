
class TowTypeModel {
  final String? id;
  final String? name;

  TowTypeModel({
    this.id,
    this.name,
  });

  factory TowTypeModel.fromJson(Map<String, dynamic> json) => TowTypeModel(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
