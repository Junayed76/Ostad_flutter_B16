import 'package:flutter/material.dart';
import 'AddNotePage.dart';


class NotesAppV1Home extends StatefulWidget {
  const NotesAppV1Home({super.key});

  @override
  State<NotesAppV1Home> createState() => _NotesAppV1HomeState();
}

class _NotesAppV1HomeState extends State<NotesAppV1Home> {
  ///Variables, logics, and etc...
  final gap = SizedBox(height: 20);
  List<String>myNotes=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///App Bar Area
      appBar: AppBar(
        title: Text(
          'Pocket Notes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.black45,
      ),

      ///Body Area Starts from here
      body: Column(
        children: [
          gap,
          Text('My Notes', style: TextStyle(fontWeight: FontWeight.bold)),

          gap,
///List of notes Area
          Expanded(
              child: ListView.builder(
                itemCount: myNotes.length,
                  itemBuilder: (context,index){
                  return Card(
                    child: ListTile(
                      title: Text('First Note'),
                    ),
                  );
                  }

              )
          ),



        ],
      ),

      //Floating Action Button Area
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNotePage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
