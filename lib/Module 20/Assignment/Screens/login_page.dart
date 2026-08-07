import 'package:b16/Module%2020/Assignment/Screens/home_page.dart';
import 'package:b16/Module%2020/Assignment/Screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '';
import '../../../Module 20/Assignment/System/api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final supabase = Supabase.instance.client;
  final apiService = ApiService();
  bool loading = false;

  //Navigation
  login() async {
    setState(() {
      loading = true;
    });
    final result = await apiService.login(
      emailController.text,
      passwordController.text,
    );
    setState(() {
      loading = false;
    });
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login successful'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed'),
          backgroundColor: Colors.deepOrange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            loading ? CircularProgressIndicator():
            ElevatedButton(onPressed: () {
              login();
            }, child: Text('Login')),
            TextButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage()));
            }, child: Text('New? Create Account')),
          ],
        ),
      ),
    );
  }
}
