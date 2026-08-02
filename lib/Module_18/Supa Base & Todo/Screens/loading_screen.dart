import 'package:b16/Module_18/Supa%20Base%20&%20Todo/Screens/home_screens.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final supabase = Supabase.instance.client;

  void initState() {
    super.initState();
    loadScreen();
  }

  loadScreen() async {
    await Future.delayed(Duration(seconds: 1));
    if (supabase.auth.currentSession == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreens()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [FlutterLogo(size: 100), CircularProgressIndicator()],
        ),
      ),
    );
  }
}
