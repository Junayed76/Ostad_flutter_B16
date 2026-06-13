import 'package:b16/module%2013/Assignment%20-%20Final/about_page.dart';
import 'package:flutter/material.dart';
import 'details_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double data = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.home_rounded), title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold,),)),
      body: Center(
        child: Column(
          children: [

            //Home Page Counter display
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.greenAccent,
              ),
              child: Text(
                '$data',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //Number Increasing Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 35,vertical: 5),
                  ),
                  onPressed: () {
                    setState(() {
                      data++;
                    });
                  },
                  child: Text(
                    'Increase',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(width: 20,),

                //Open details page button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(data: data),
                      ),
                    );
                  },
                  child: Text(
                    'Open details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      //Bottom Navigation Bar Starts --- here ---
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) {
          if (i == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          }
          if (i == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutPage()),
            );
          }
        },

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline_rounded),
            label: 'About',
          ),
        ],
      ),
    );
  }
}
