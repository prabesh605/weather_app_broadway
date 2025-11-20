// To parse this JSON data, do
//
//     final mobile = mobileFromJson(jsonString);

import 'dart:convert';

List<Mobile> mobileFromJson(String str) =>
    List<Mobile>.from(json.decode(str).map((x) => Mobile.fromJson(x)));

String mobileToJson(List<Mobile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Mobile {
  String id;
  String name;
  Data? data;

  Mobile({required this.id, required this.name, required this.data});

  factory Mobile.fromJson(Map<String, dynamic> json) => Mobile(
    id: json["id"],
    name: json["name"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "data": data?.toJson(),
  };
}

class Data {
  String? dataColor;
  String? dataCapacity;
  int? capacityGb;
  double? dataPrice;
  String? dataGeneration;
  int? year;
  String? cpuModel;
  String? hardDiskSize;
  String? strapColour;
  String? caseSize;
  String? color;
  String? description;
  String? capacity;
  double? screenSize;
  String? generation;
  String? price;

  Data({
    this.dataColor,
    this.dataCapacity,
    this.capacityGb,
    this.dataPrice,
    this.dataGeneration,
    this.year,
    this.cpuModel,
    this.hardDiskSize,
    this.strapColour,
    this.caseSize,
    this.color,
    this.description,
    this.capacity,
    this.screenSize,
    this.generation,
    this.price,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dataColor: json["color"],
    dataCapacity: json["capacity"],
    capacityGb: json["capacity GB"],
    dataPrice: json["price"]?.toDouble(),
    dataGeneration: json["generation"],
    year: json["year"],
    cpuModel: json["CPU model"],
    hardDiskSize: json["Hard disk size"],
    strapColour: json["Strap Colour"],
    caseSize: json["Case Size"],
    color: json["Color"],
    description: json["Description"],
    capacity: json["Capacity"],
    screenSize: json["Screen size"]?.toDouble(),
    generation: json["Generation"],
    price: json["Price"],
  );

  Map<String, dynamic> toJson() => {
    "color": dataColor,
    "capacity": dataCapacity,
    "capacity GB": capacityGb,
    "price": dataPrice,
    "generation": dataGeneration,
    "year": year,
    "CPU model": cpuModel,
    "Hard disk size": hardDiskSize,
    "Strap Colour": strapColour,
    "Case Size": caseSize,
    "Color": color,
    "Description": description,
    "Capacity": capacity,
    "Screen size": screenSize,
    "Generation": generation,
    "Price": price,
  };
}
