import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactPage(),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
        centerTitle: true,
        backgroundColor: Colors.blue[100],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          children: [

            // Name Field
            TextField(
              decoration: InputDecoration(
                hintText: "Hasan",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            // Phone Field
            TextField(
              decoration: InputDecoration(
                hintText: "01745-777777",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            // Add Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[100]
                ),
                onPressed: () {},
                child: const Text("Add",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),

            const SizedBox(height: 20),

            // Contact List
            Expanded(
              child: ListView(
                children: const [

                  ContactTile(
                    name: "Jawad",
                    phone: "01877-777777",
                  ),

                  ContactTile(
                    name: "Ferdous",
                    phone: "01673-777777",
                  ),

                  ContactTile(
                    name: "Hasan",
                    phone: "01745-777777",
                  ),

                  ContactTile(
                    name: "Hasan",
                    phone: "01745-777777",
                  ),

                  ContactTile(
                    name: "Hasan",
                    phone: "01745-777777",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  final String name;
  final String phone;

  const ContactTile({
    super.key,
    required this.name,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.person),

        title: Text(
          name,
          style: const TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(phone),

        trailing: const Icon(
          Icons.phone,
          color: Colors.blue,
        ),
      ),
    );
  }
}