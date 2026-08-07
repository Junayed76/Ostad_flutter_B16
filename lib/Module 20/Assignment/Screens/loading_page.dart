import 'package:b16/Module%2020/Assignment/Screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final supabase = Supabase.instance.client;

  void initState() {
    super.initState();
    forward();
  }

  forward() async {
    await Future.delayed(Duration(seconds: 5));
    if (supabase.auth.currentSession == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: ((context) => LoginPage())),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: ((context) => HomePage())),
      );
    }
  }

  String loadingImg = 'assets/images/loadingImg.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(loadingImg, height: 50, width: 50),
            SizedBox(height: 16.0),
            CircularProgressIndicator(),
            SizedBox(height: 16,),
            Text("Loading...World's Best Todo App",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green),),
          ],
        ),
      ),
    );
  }
}
