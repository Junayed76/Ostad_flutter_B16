Supa Todo Application

This application is a todo app that uses Supabase for authentication and data storage.

features:
- User Authentication
- Todo Creation
- Todo Update
- Todo 


return ListTile(
title: Text("Task ${widget.newTasks[index]}"),
subtitle: Text("Status"),
trailing: Row(
mainAxisSize: MainAxisSize.min,
children: [
IconButton(
onPressed: () {
updateTask(index);
},
icon: Icon(Icons.edit),
),
Checkbox(
value: false,
onChanged: (value) {
setState(() {
deleteFromSupa(widget.newTasks[index]);
widget.completedTasks.add(widget.newTasks[index]);
widget.newTasks.removeAt(index);

                          //addToCompletedTasks(widget.newTasks[index]);
                        });
                      },
                    ),
                  ],
                ),
              );