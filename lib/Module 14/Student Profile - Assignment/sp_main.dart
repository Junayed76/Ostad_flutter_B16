import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

void main() => runApp(const MaterialApp(
  home: Home(),
));

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() => loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: loading
            ? Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Container(
            width: 250,
            height: 320,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        )
            : Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          child: Container(
            width: 250,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Badge(
                  label: const Text("New"),
                  child: const CircleAvatar(
                    radius: 35,
                    child: Icon(Icons.person, size: 35),
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Jashim",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const Text("ID: STU-2025-0042"),
                const Text(
                  "Computer Science & Engineering",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Student Details"),
                          content: const Text(
                            "Name: Mike Rack\n\n"
                                "ID: STU-2025-0042\n\n"
                                "Department: CSE",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Close"),
                            )
                          ],
                        ),
                      );
                    },
                    child: const Text("View Details"),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                          Text("Mike Rack marked as Present ✅"),
                        ),
                      );
                    },
                    child: const Text("Mark Present"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}