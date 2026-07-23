import 'model.dart';
import 'package:flutter/material.dart';

class PostDetailsScreen extends StatelessWidget {

  final String PostId;
  const PostDetailsScreen({super.key, required this.PostId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(PostId),),
    );
  }
}
