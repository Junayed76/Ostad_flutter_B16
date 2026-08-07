import 'package:b16/Module%2020/Assignment/Screens/home_page.dart';
import 'package:b16/Module%2020/Assignment/Screens/login_page.dart';
import 'package:flutter/material.dart';

import '../../../Module 20/Assignment/System/api_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  final apiService = ApiService();

  signup() async {
    setState(() {
      loading = true;
    });
    final result = await ApiService().signUp(
      userNameController.text,
      emailController.text,
      passwordController.text,
    );
    setState(() {
      loading = false;
    });
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User created successfully'),
          backgroundColor: Colors.blue,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign Up Failed'),
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
            Text('Join With Us',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
            SizedBox(height: 16.0),
            TextFormField(
              controller: userNameController,
              decoration: InputDecoration(
                labelText: 'User Name',
                border: OutlineInputBorder(),
              ),
            ),
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
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 16.0),
                ),
                onPressed: (){
              signup();
            }, child: Text('Sign Up')),
            TextButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
            }, child: Text('Or Login')),
          ],
        ),
      ),
    );
  }
}
