import 'package:http/http.dart' as http;
import 'model.dart';
import 'dart:convert';

class apiService {
  static Future<List<model>?> fetchData() async {
    final url = Uri.parse(
      'https://crud-api-ostad-live.onrender.com/api/v1/ReadProduct',
    );
    final response = await http.get(url);

    //print(response.statusCode);

    if (response.statusCode == 200) {
      //print('succesful');
      //print(response.body.runtimeType);
      final jsonData = jsonDecode(response.body);
      final theData = jsonData['data'] as List;
      return theData.map((e)=> model.fromJson(e) ).toList();
    }
  }
}