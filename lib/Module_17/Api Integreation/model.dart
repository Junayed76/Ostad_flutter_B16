class model {
  final String id;
  final String productName;
  final String img;
  final int price;

  model({
    required this.id,
    required this.productName,
    required this.img,
    required this.price,
  });
  factory model.fromJson(Map<String, dynamic> json) {
    return model(
      id: json['_id'],
      productName: json['ProductName'],
      img: json['Img'],
      price: json['UnitPrice'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "Img": img,
      "ProductCode": DateTime.now().millisecondsSinceEpoch,
      "ProductName": productName,
      "Qty": 1,
      "TotalPrice": price,
      "UnitPrice": price,
    };
  }
}
