import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewTask extends StatefulWidget {
  List<String> newTasks = [];
  List<String> completedTasks = [];
  NewTask({super.key, required this.newTasks, required this.completedTasks});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  //Variables and methods for NewTask can be added here
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    loadFromSupa();
  }
  List<Map<String, dynamic>> TaskPackage = [];

  loadFromSupa()async{
    try{
      final result = await supabase.from('task table').select('*');
      setState(() {
        TaskPackage = result;
      });
    }catch(e){
      print(e);
    }
  }

  deleteFromSupa(dynamic data) async {
    try {
      await supabase.from('task table').delete().eq('id', data['id']);
    } catch (e) {
      print(e);
    }
  }

  updateTaskFromSupa(Map<String, dynamic> theTask) async {
    try{
      await supabase
          .from('task table')
          .update({'task': theTask['task']})
          .eq('id', theTask['id']);
    }catch(e){
      print(e);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Card(
          color: Colors.white70,
          child: ListView(
            children: [
              for(var task in TaskPackage)
                ListTile(
                  title: Text("Task ${task['task']}"),
                  subtitle: Text("Status"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          updateTask(task);
                        },
                        icon: Icon(Icons.edit),
                      ),
                      Checkbox(
                        value: false,
                        onChanged: (value) {
                          setState(() {
                            deleteFromSupa(task);
                            widget.completedTasks.add(task['task']);
                            TaskPackage.remove(task);


                            //addToCompletedTasks(widget.newTasks[index]);
                          });
                        },
                      ),
                    ],
                  ),

                )
            ],
          ),
        ),
      ),
    );


  }void updateTask(Map<String, dynamic> task) async {
    final cont = TextEditingController(text: task['task']);
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Update Task'),
        content: TextField(controller: cont,),
        actions: [
          ElevatedButton(onPressed: ()async{
            setState(() {
              task['task'] = cont.text;
            });
            await updateTaskFromSupa(task);
            Navigator.pop(context);
          }, child: Text('Update')),
        ],
      );
    });
  }
}
