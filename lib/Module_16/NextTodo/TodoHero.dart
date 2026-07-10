import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: true, home: Todohero()));
}

class Todohero extends StatefulWidget {
  const Todohero({super.key});

  @override
  State<Todohero> createState() => _TodoheroState();
}

class _TodoheroState extends State<Todohero> {
  TextEditingController _taskInput = TextEditingController();
  List<Map<String, dynamic>> _taskList = [];
  @override
  ///It's responsible to reloading data from db after application starts
  void initState() {
    super.initState();
    _refreshUI();
  }

  void _refreshUI() async {
    var importedData = await TodoHeroDB.instance.readTask();
    setState(() {
      _taskList = importedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo Hero'), centerTitle: true),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _taskInput,
                  decoration: InputDecoration(
                    hintText: 'eat rice with fried egg',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await TodoHeroDB.instance.createTask(_taskInput.text);
                  _taskInput.clear();
                  _refreshUI();
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
          Expanded(
            child: _taskList.isEmpty
                ? const Center(child: Text('No task'))
                : ListView.builder(
                    itemCount: _taskList.length,
                    itemBuilder: (context, index) {
                      final iData = _taskList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text('${iData[TodoHeroDB.colSl]}'),
                        ),
                        title: Text('${iData[TodoHeroDB.colTask]}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                _showUpdateDialoge(
                                  iData[TodoHeroDB.colSl],
                                  iData[TodoHeroDB.colTask],
                                );
                                _refreshUI();
                              },
                              icon: Icon(Icons.edit_note_sharp),
                            ),
                            IconButton(
                              onPressed: () async {
                                await TodoHeroDB.instance.deleteTask(
                                  iData[TodoHeroDB.colSl],
                                );
                                _refreshUI();
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  ///Ui for update function
  void _showUpdateDialoge(int Sl, String task) {
    TextEditingController _task = TextEditingController(text: task);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Update Task'),
        content: TextFormField(controller: _task),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context as BuildContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await TodoHeroDB.instance.updateTask(Sl, _task.text);
              if (mounted) Navigator.pop(context as BuildContext);
              _refreshUI();
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}

/// ______________________________
///Database with CRUD Begins here
///-----------------------------

class TodoHeroDB {
  ///_____________________________________________________
  ///There I made the single constructor of our Database
  TodoHeroDB._();
  static final TodoHeroDB instance = TodoHeroDB._();

  ///________________________________________________
  ///Here I made some frequently usable variables
  static final String tableName = 'Todo_Hero';
  static final String colSl = 'Serial_of_tasks';
  static final String colTask = 'My_tasks';

  ///___________________________________
  ///There I created an empty variable of database to store our database in it
  Database? _database;

  ///______________
  ///Here is the method which will ensure that the db is created, if not then it will send request to create one.
  Future<Database> get checkDB async {
    _database ??= await createDB();
    return _database!;
  }

  ///_____________________________________________________________________________
  ///This method mainly create the db file in the users device
  Future<Database> createDB() async {
    Directory findPath =
        await getApplicationDocumentsDirectory(); //It's find the directory folder's path where it will store the db
    String path = p.join(
      findPath.path,
      'todoHero.db',
    ); //It's added the db file name after the directory file's path
    return openDatabase(
      path,
      version: 1,
      onCreate: (tempDB, version) async {
        await tempDB.execute(
          'CREATE TABLE $tableName($colSl integer primary key autoincrement, $colTask text)',
        );
      },
    );
  }

  ///___________________________________________________________________________
  ///There I add the CRUD
  ///First of all *CREATE*
  ///We are going to use it for inserting new tasks in the table
  Future<int> createTask(String task) async {
    var database = await checkDB;
    return database.insert(tableName, {colTask: task});
  }

  ///2nd == Read (Select * from) & it helps to print all tasks on UI
  Future<List<Map<String, dynamic>>> readTask() async {
    var database = await checkDB;
    return database.query(tableName);
  }

  ///3rd == Update
  Future<int> updateTask(int Sl, String newTask) async {
    var database = await checkDB;
    return database.update(
      tableName,
      {colTask: newTask},
      where: '$colSl= ?',
      whereArgs: [Sl],
    );
  }

  ///4th == Delete
  Future<int> deleteTask(int Sl) async {
    var database = await checkDB;
    return database.delete(tableName, where: '$colSl= ?', whereArgs: [Sl]);
  }
}
