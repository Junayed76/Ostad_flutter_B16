import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final supabase_url = dotenv.env['supabase_url'];
final supabase_key = dotenv.env['publishable_key'];

class ApiService {
  // Login user <write>
  Future<Map<String, dynamic>?> login(String email, String password) async {
    Uri url = Uri.parse('$supabase_url/auth/v1/token?grant_type=password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'apikey': supabase_key!},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }

  // Sign up new user <write>
  Future<Map<String, dynamic>?> signUp(
    String userName,
    String email,
    String password,
  ) async {
    Uri url = Uri.parse('$supabase_url/auth/v1/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'apikey': supabase_key!},
      body: jsonEncode({
        'email': email,
        'password': password,
        'data': {'userName': userName},
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }

  //-------------------------------------------------------------------------------

  // Add new task on server and store  it <write>
  Future<Map<String, dynamic>?> newTask(String name, String description) async {
    Uri url = Uri.parse('$supabase_url/rest/v1/task');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'apikey': supabase_key!},
      body: jsonEncode({'task_name': name, 'task_desc': description}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }

  // Load New task from server and show in list <read>
  Future<List<Map<String, dynamic>>?> readNewTask() async {
    Uri url = Uri.parse('$supabase_url/rest/v1/task');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'apikey': supabase_key!},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      print(
        'readNewTask failed: ${response.statusCode} ${response.body}',
      ); // debug

      return null;
    }
  }

  // Delete task from new task list <delete>
  Future<Map<String, dynamic>?> deleteTask(int id) async {
    Uri url = Uri.parse('$supabase_url/rest/v1/task?id=eq.$id');
    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json', 'apikey': supabase_key!},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }

  //-----------------------------------------------------------------------------

  // Add New task to progress task list <write>
  Future<Map<String, dynamic>?> writeProgressTask(
    String name,
    String description,
    int id,
  ) async {
    Uri url = Uri.parse('$supabase_url/rest/v1/progress_task');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'apikey': supabase_key!},
      body: jsonEncode({'task_name': name, 'task_desc': description, 'id': id}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body.isEmpty) {
        return {'success': true}; // <-- empty hole crash na kore success dhori
      }

      final data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }

  // Load Progress task from server and show in list <read>
  Future<List<Map<String, dynamic>>?> readProgressTask() async {
    Uri url = Uri.parse('$supabase_url/rest/v1/progress_task');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'apikey': supabase_key!},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      return null;
    }
  }

  // Delete task from progress task list <delete>
  Future<Map<String, dynamic>?> deleteProgressTask(int id) async {
    Uri url = Uri.parse('$supabase_url/rest/v1/progress_task?id=eq.$id');
    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json', 'apikey': supabase_key!},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }

  //-------------------------------------------------------------------------------

  // Add New task to progress task list <write>
  Future<Map<String, dynamic>?> writeCompletedTask(
    String name,
    String description,
    int id,
  ) async {
    Uri url = Uri.parse('$supabase_url/rest/v1/completed_task');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'apikey': supabase_key!},
      body: jsonEncode({'task_name': name, 'task_desc': description, 'id': id}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body.isEmpty) {
        return {'success': true}; // <-- empty hole crash na kore success dhori
      }

      final data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }

  // Load Progress task from server and show in list <read>
  Future<List<Map<String, dynamic>>?> readCompletedTask() async {
    Uri url = Uri.parse('$supabase_url/rest/v1/completed_task');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'apikey': supabase_key!},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      return null;
    }
  }

  // Delete task from new task list <delete>
  Future<Map<String, dynamic>?> deleteCompletedTask(int id) async {
    Uri url = Uri.parse('$supabase_url/rest/v1/completed_task?id=eq.$id');
    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json', 'apikey': supabase_key!},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }
}
