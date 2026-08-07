import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {








  final imgUrl =
      'https://t4.ftcdn.net/jpg/06/20/21/35/360_F_620213582_bRI0JqxMT31ga9PRgrUHh8peZqQUEoMf.jpg';

  final newTask = [];
  final progressTask = [];
  final completeTask = [];

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    print('Current user: $user');
    print('User metadata: ${user?.userMetadata}');
    final userName = user?.userMetadata?['userName'] ?? 'Name not found';
    final userEmail = user?.email ?? 'Email not found';
    //final userPassword = user?.password ?? 'No Password';
    return Container(
      color: Colors.green,
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                60,
              ),
              child: Image.network(
                imgUrl,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Text('Name: $userName',style: TextStyle(fontSize: 18),),
            Text('Email: $userEmail',style: TextStyle(fontSize: 18),),
            Text('Password: userPassword',style: TextStyle(fontSize: 18),),
            Text('New Tasks: ${newTask.length}',style: TextStyle(fontSize: 18),),
            Text('Progress Tasks: ${progressTask.length}',style: TextStyle(fontSize: 18),),
            Text('Completed Tasks: ${completeTask.length}',style: TextStyle(fontSize: 18),),
            Text(
              'Efficiency: ${newTask.length / (newTask.length + progressTask.length + completeTask.length)}',
            style: TextStyle(fontSize: 18),),
          ],
        ),
      ),
    );
  }
}
