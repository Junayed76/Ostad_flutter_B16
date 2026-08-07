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
    await Future.delayed(Duration(seconds: 1));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [FlutterLogo(size: 50), CircularProgressIndicator()],
        ),
      ),
      bottomSheet: Text('Version Alpha 1'),
    );
  }
}
