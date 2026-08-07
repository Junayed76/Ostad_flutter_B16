import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:b16/Module%2020/Assignment/Screens/loading_page.dart';

import '../Screens/addtask_page.dart';




Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.get('supabase_url'),
    publishableKey: dotenv.get('publishable_key'),
  );
  runApp(MaterialApp(home:LoadingPage(),debugShowCheckedModeBanner: false,));
}




