import 'package:flutter/material.dart';
import 'weather_app_v1_home.dart';


void main(){
  runApp(WeatherAppV1());
}

class WeatherAppV1 extends StatelessWidget {
  const WeatherAppV1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherAppV1Home(),
    );
  }
}


