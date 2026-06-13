import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final double ?data;
  const DetailsPage({super.key,  this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Icon(Icons.arrow_back)),
        title: Text('Details',style: TextStyle(fontWeight: FontWeight.bold,),),
      ),
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

            //Back Button
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text(
                'Back',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
