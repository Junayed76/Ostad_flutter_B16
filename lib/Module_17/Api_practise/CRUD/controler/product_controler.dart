import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/product_model.dart';
import '../utils/urls.dart';

class ProductController {
  List<Data> products = [];
  Future<void> getProducts() async {
    final url = Uri.parse(Urls.readProduct);
    final response = await http.get(url);
    print(response.statusCode);
    print(response.body);

    final jsonResponse = jsonDecode(response.body);

    ProductModel model = ProductModel.fromJson(jsonResponse);

    products = model.data;

  }
}