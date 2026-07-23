import 'package:http/http.dart' as http;
import 'model.dart';
import 'dart:convert';
import 'url_services.dart';

class ApiService {
  ///Read Product method
  static Future<List<model>?> fetchData() async {
    final url = ApiConfig.readProductApi;
    final response = await http.get(url);

    //print(response.statusCode);

    if (response.statusCode == 200) {
      print('successful');
      print(response.statusCode);
      final jsonData = jsonDecode(response.body);
      final theData = jsonData['data'] as List;
      return theData.map((e) => model.fromJson(e)).toList();
    }
  }

  ///Create product method
  static Future<dynamic> createData(model newProduct) async {
    final willCreate = await http.post(
      ApiConfig.createProductApi,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(newProduct.toJson()),
    );

    if (willCreate.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future deleteData(String Id) async{
    final response = await http.get(ApiConfig.deleteProductApi(Id));
    if(response.statusCode == 200){
      return true;
    }else {
      return false;
    }
  }
}
