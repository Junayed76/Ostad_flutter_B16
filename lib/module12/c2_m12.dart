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

  bool change = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SingleChildScrollView(),
                Form(
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
                                FocusScope.of(
                                  context,
                                ).requestFocus(SubmitButton);
                              },
                              validator: (value) {
                                if (value!.length < 7) {
                                  return 'Atleast 7 character';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
                              ),
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


                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      change = !change;
                    });
                  },
                  child: Text('Animate'),
                ),
                Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(seconds: 3),
                      height: change ? 300 : 100,
                      width: change ? 200 : 100,
                      color: change ? Colors.blue : Colors.red,
                    ),
                    AnimatedOpacity(
                      opacity: change ? 1 : 0,
                      duration: Duration(seconds: 2),
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.orange,
                      ),
                    ),
                    AnimatedAlign(
                      alignment: change ? Alignment.center : Alignment.bottomLeft,
                      duration: Duration(seconds: 2),
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.orange,
                      ),
                    ),
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 100),
                      duration: Duration(seconds: 52),
                      builder: (context, value, child) {
                        return Text(
                          '${value.toInt()}',
                          style: TextStyle(fontSize: 40),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
