import 'package:flutter/material.dart';

void main() {
  runApp(Map());
}

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pass = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FocusNode emails = FocusNode();
  FocusNode passw = FocusNode();
  FocusNode submitBtn = FocusNode();

  @override

  void dispose(){
    emails.dispose();
    passw.dispose();
    emailController.dispose();
    pass.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  focusNode: emails,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(passw);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'abc@baba.com',
                  ),
                ),
                TextFormField(
                  focusNode: passw,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(submitBtn);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required';
                    } else if (value.length < 6) {
                      return 'Min 6 cha';
                    }
                    return null;
                  },
                  controller: pass,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: '!@aeioJi',
                  ),
                ),
                ElevatedButton(
                  focusNode: submitBtn,
                  onPressed: () {
                    formKey.currentState!.validate();
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
