import 'package:b16/Module_18/Supa%20Base%20&%20Todo/Screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../Screens/home_screens.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.get('supabase_url'),
    publishableKey: dotenv.get('publishable_key'),
  );
  runApp(MaterialApp(
      home: LoadingScreen()
  ));
}