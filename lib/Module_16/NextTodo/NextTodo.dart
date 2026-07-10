import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// ==========================================
// ১. ডাটাবেজ পার্ট (DATABASE LAYER)
// ==========================================
class TodoDB {
  TodoDB._();
  static final TodoDB instance = TodoDB._();

  static const String tableName = 'todos';
  static const String colId = 'id';
  static const String colTitle = 'title';

  Database? _db;

  //Ekhane database method ta uporer _db er moddhe database load diye oi fullfilled _db rtrn kore .. so jodi db = await database poro tar mane holo=> db = _db;
  Future<Database> get database async {
    //Database created na thakle create korbe..thakle ta _db er moddhe vore dibe....
    _db ??= await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, 'todo_simple.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT)',
        );
      },
    );
  }

  // ডাটা যোগ করা (CREATE)
  //Ei method ta title er name recive kore
  Future<int> addTodo(String title) async {
    //amra jani already db = _db = Database
    var db = await database;
    //so db te insert korle ota auto _db/Database e chole jay
    return await db.insert(tableName, {colTitle: title});
  }

  // সব ডাটা আনা (READ)
  Future<List<Map<String, dynamic>>> getTodos() async {
    //amra abaro _db ke db er moddhe dilam ; ete crash howar chance kome thakbe na
    var db = await database;
    // ekhane query = select * from..eta bolse: db er ei table tar moddhe ja ase sob print koro.
    return await db.query(tableName);
  }

  // ডাটা এডিট করা (UPDATE)
  Future<int> updateTodo(int id, String newTitle) async {
    var db = await database;
    //etao same ekhan e update holo sql er cmd
    return await db.update(
      tableName,
      {
        colTitle: newTitle,
      }, //ekhan e ? ta id dara replace hoye jabe .. ar table er oi id ta update hobe...
      where: '$colId = ?',
      whereArgs: [id],
    );
  }

  // ডাটা মুছে ফেলা (DELETE)
  Future<int> deleteTodo(int id) async {
    var db = await database;
    return await db.delete(tableName, where: '$colId = ?', whereArgs: [id]);
  }
}

// ==========================================
// ২. মেইন অ্যাপ ও UI পার্ট (UI LAYER)
// ==========================================
void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: TodoScreen()),
  );
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _todoList = [];

  @override
  void initState() {
    super.initState(); //app ke prev last state e neyar command
    _refreshTodos(); // last state e neyar logic
  }

  // ডাটাবেজ থেকে ডাটা এনে UI রিফ্রেশ করার কমন ফাংশন
  void _refreshTodos() async {
    final data = await TodoDB.instance.getTodos();
    setState(() {
      _todoList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Easy SQL + UI')),
      body: Column(
        children: [
          // ইনপুট ফিল্ড এবং অ্যাড বাটন (CREATE UI)
          Padding(
            padding: const EdgeInsets.all(12.0),
            //padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter Task...',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_controller.text.isNotEmpty) {
                      await TodoDB.instance.addTodo(
                        _controller.text,
                      ); // ১. ডাটাবেজে সেভ
                      _controller.clear();
                      _refreshTodos(); // ২. UI আপডেট
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),

          // ডাটা দেখানোর লিস্ট (READ, UPDATE, DELETE UI)
          Expanded(
            child: _todoList.isEmpty
                ? const Center(child: Text('No Task Found!'))
                : ListView.builder(
                    itemCount: _todoList.length,
                    itemBuilder: (context, index) {
                      final todo = _todoList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text('${todo[TodoDB.colId]}'),
                        ),
                        title: Text(todo[TodoDB.colTitle]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // এডিট বাটন (UPDATE)
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () async {
                                // এডিটের জন্য ডায়ালগ বক্স ওপেন হবে
                                _showEditDialog(
                                  context,
                                  todo[TodoDB.colId],
                                  todo[TodoDB.colTitle],
                                );
                              },
                            ),
                            // ডিলিট বাটন (DELETE)
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await TodoDB.instance.deleteTodo(
                                  todo[TodoDB.colId],
                                ); // ১. ডিলিট
                                _refreshTodos(); // ২. UI আপডেট
                              },
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

  // ডাটা আপডেট করার সহজ পপআপ ডায়ালগ
  void _showEditDialog(BuildContext context, int id, String currentTitle) {
    final editController = TextEditingController(text: currentTitle);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Task'),
        content: TextField(controller: editController),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await TodoDB.instance.updateTodo(
                id,
                editController.text,
              ); // ১. আপডেট
              if (mounted) Navigator.pop(context);
              _refreshTodos(); // ২. UI আপডেট
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
