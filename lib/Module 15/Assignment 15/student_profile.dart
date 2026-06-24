import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // App start korar jonno
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Debug banner hide
      home: ProfilePage(), // First screen
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200, // Page er background color

      appBar: AppBar(
        title: const Text("Profile Card"), // App bar title
        centerTitle: true, // Title center e anar jonno
      ),

      body: SingleChildScrollView( // Overflow hole scroll korbe
        child: Padding(
          padding: const EdgeInsets.all(10), // Sob dike gap

          child: Column(
            children: [

              //  Profile Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),

                  child: Column(
                    children: [

                      // User er profile picture
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          "https://i.pravatar.cc/150",
                        ),
                      ),

                      const SizedBox(height: 10), // Gap

                      // User name
                      const Text(
                        "John Doe",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // User profession
                      const Text(
                        "Flutter Developer",
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 10),

                      // Short description
                      const Text(
                        "Passionate about creating user-friendly and engaging digital experiences.",
                        textAlign: TextAlign.center,
                      ),

                      const Divider(height: 30), // Line separator

                      // Email row
                      const Row(
                        children: [
                          Icon(Icons.email),
                          SizedBox(width: 10),
                          Text("john.doe@example.com"),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Phone row
                      const Row(
                        children: [
                          Icon(Icons.phone),
                          SizedBox(width: 10),
                          Text("+123 456 7890"),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Follow & Message button
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text("Follow"),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Text("Message"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //  Interests Heading
              const Text(
                "Interests",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              //  Interest Cards
              Row(
                children: [

                  // Travel Card
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // Travel image
                            Image.network(
                              "https://picsum.photos/200/120?1",
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),

                            const SizedBox(height: 8),

                            // Interest title
                            const Text(
                              "Travel",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // Interest description
                            const Text(
                              "Exploring new places around the world",
                              style: TextStyle(fontSize: 12),
                            ),

                            const SizedBox(height: 10),

                            // Button
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text("View More"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Photography Card
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // Photography image
                            Image.network(
                              "https://picsum.photos/200/120?2",
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),

                            const SizedBox(height: 8),

                            // Interest title
                            const Text(
                              "Photography",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // Interest description
                            const Text(
                              "Capturing moments through the lens",
                              style: TextStyle(fontSize: 12),
                            ),

                            const SizedBox(height: 10),

                            // Button
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text("View More"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}