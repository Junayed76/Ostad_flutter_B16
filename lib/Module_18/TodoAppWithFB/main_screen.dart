import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: HomeScreen(), debugShowCheckedModeBanner: false));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///Variables and etc...
  bool personal = true, college = false, office = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo Fire'), backgroundColor: Colors.white70),
      body: Container(
        padding: EdgeInsets.only(top: 70, left: 20),
        height: MediaQuery.of(context).size.height,
        //Media Query resize ui according to the device
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.white70, Colors.white54]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                'Hii,',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Text(
                'Sohel',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 52),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //#1
                personal
                    ? Material(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                          decoration: BoxDecoration(color: Colors.greenAccent,borderRadius: BorderRadius.circular(20),),
                          child: Text(
                            'Personal',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          personal = true;
                          office = false;
                          college = false;
                          setState(() {});
                        },
                        child: Text('Personal'),
                      ),
                //#2
                office
                    ? Material(

                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                          decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(20),),
                          child: Text(
                            'Office',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          personal = false;
                          office = true;
                          college = false;
                          setState(() {});
                        },
                        child: Text('Office'),
                      ),
                //#3
                college
                    ? Material(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                          decoration: BoxDecoration(color: Colors.orangeAccent,borderRadius: BorderRadius.circular(20),),
                          child: Text(
                            'College',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          personal = false;
                          office = false;
                          college = true;
                          setState(() {});
                        },
                        child: Text('College'),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
