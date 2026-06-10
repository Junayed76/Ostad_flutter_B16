import 'package:flutter/material.dart';

void main() {
  runApp(shala());
}

class shala extends StatefulWidget {
  const shala({super.key});

  @override
  State<shala> createState() => _shalaState();
}

class _shalaState extends State<shala> {
  int currentStep = 0;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final emailFormKey = GlobalKey<FormState>();
  final passFormKey = GlobalKey<FormState>();
  FocusNode SubmitButton = FocusNode();
  void login() {
    //bool PassValid = passFormKey.currentState!.validate();
    if (emailFormKey.currentState!.validate()) {
      print('Login Successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Form(
            key: emailFormKey,
            child: Column(
              children: [
                Stepper(
                  currentStep: currentStep,
                  onStepContinue: () {
                    if (currentStep == 0) {
                      if (emailController.text.contains('@')) {
                        setState(() {
                          currentStep++;
                        });
                      }
                    } else if (currentStep == 1) {
                      if (passController.text != null &&
                          passController.text.length > 6) {
                        login();
                      }
                    }
                  },
                  onStepCancel: () {
                    setState(() {
                      currentStep--;
                    });
                  },
                  steps: [
                    Step(
                      title: Text('Email'),
                      content: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (!value!.contains('@')) {
                            return 'Incorrect';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                    ),
                    Step(
                      title: Text('Pass'),
                      content: TextFormField(
                        controller: passController,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(SubmitButton);
                        },
                        validator: (value) {
                          if (value!.length < 7) {
                            return 'Atleast 7 character';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Password'),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  focusNode: SubmitButton,
                  onPressed: () {
                    login();
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}
