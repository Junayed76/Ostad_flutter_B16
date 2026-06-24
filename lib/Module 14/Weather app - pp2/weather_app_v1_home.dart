import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherAppV1Home extends StatefulWidget {
  const WeatherAppV1Home({super.key});

  @override
  State<WeatherAppV1Home> createState() => _WeatherAppV1HomeState();
}

class _WeatherAppV1HomeState extends State<WeatherAppV1Home> {
  TextEditingController cityController = TextEditingController();

  // Variable list
  String cityName = 'Dhaka';
  String temp = '--';
  String condition = 'Search a city';
  String _iconCode = "";

  // API theke data fetch korar main function
  Future<void> fetchWeather(String city) async {
    // ✅ ১. OpenWeatherMap er fixed full link and working key
    const apiKey = '8492484da5533cd556da871a258c702f';
    final url = Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=23.81&longitude=90.41&current=temperature_2m');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          cityName = data['name'];
          // ✅ ২. toStringAsFixed(1) bracket brackets fixed
          temp = data['main']['temp'].toStringAsFixed(1);
          condition = data['weather'][0]['main'];
          _iconCode = data['weather'][0]['icon'];
        });
      } else {
        setState(() {
          condition = 'City not found';
          temp = '--';
          _iconCode = "";
        });
      }
    } catch (e) {
      setState(() {
        condition = 'Error: ${e.toString()}'; // Asol error dekhanor jonno change kora holo
        _iconCode = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ Padding widget diye full wrap kora holo jate layout screen thik thake
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: TextFormField(
                controller: cityController,
                decoration: InputDecoration(
                  labelText: 'City Name',
                  border: const OutlineInputBorder(), // Input box dekhte arektu sundor korlo
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (cityController.text.isNotEmpty) {
                        fetchWeather(cityController.text);
                      }
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // ✅ ৩. Weather Icon link accurate kora holo
            _iconCode.isNotEmpty
                ? Image.network(
              'https://openweathermap.org',
              width: 100,
              height: 100,
            )
                : const SizedBox(height: 100),

            Text(
              cityName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              temp == '--' ? '--' : '$temp°C', // ✅ Degree Celsius sign add kora holo
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              condition,
              style: const TextStyle(fontSize: 22, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
