// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel{
  String status;
  List<Data> data;

  ProductModel({
    required this.status,
    required this.data,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    status: json["status"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Data {
  String id;
  String productName;
  int productCode;
  String img;
  int qty;
  int unitPrice;
  int totalPrice;

  Data({
    required this.id,
    required this.productName,
    required this.productCode,
    required this.img,
    required this.qty,
    required this.unitPrice,
    required this.totalPrice,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    productName: json["ProductName"],
    productCode: json["ProductCode"],
    img: json["Img"],
    qty: json["Qty"],
    unitPrice: json["UnitPrice"],
    totalPrice: json["TotalPrice"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "ProductName": productName,
    "ProductCode": productCode,
    "Img": img,
    "Qty": qty,
    "UnitPrice": unitPrice,
    "TotalPrice": totalPrice,
  };
}
