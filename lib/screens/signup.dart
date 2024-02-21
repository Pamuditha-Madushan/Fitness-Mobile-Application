import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/main.dart';
import 'package:flutter_project/screens/home.dart';
import 'package:flutter_project/screens/login.dart';
import 'package:flutter_project/theme.dart';
import 'package:flutter_project/widgets/navigation_bar.dart';
import 'package:flutter_project/widgets/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/primary_button.dart';

class SignUpScreen extends StatefulWidget {
  static const String idScreen = "register";

  SignUpScreen(BuildContext context);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObscure = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FormColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: prefer_const_constructors
              SizedBox(
                height: 50,
              ),
              Container(
                child: new Image.asset(
                    'images/clipart-exercise-fitness-centre-19.png'),
                width: MediaQuery.of(context).size.width,
                height: 100,
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 15,
              ),
              Text(
                'Enter your credential to continue',
                style: TextStyle(
                  fontSize: 15,
                  color: SecondaryTestColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameTextEditingController,
                          decoration: InputDecoration(
                            labelText: "Username",
                            labelStyle: TextStyle(
                              color: TextFieldColor,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: emailTextEditingController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: TextFieldColor,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordTextEditingController,
                          obscureText: isObscure,
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                color: TextFieldColor,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                              )),
                        ),
                      ],
                    )),
              ),

              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "By continuing you agree to our",
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Terms of Service',
                      style: TextStyle(
                        color: PrimaryColor,
                      ),
                    ),
                  )
                ],
              ),

              Row(
                children: [
                  Text(
                    "and",
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: PrimaryColor,
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(
                height: 30,
              ),

              InkWell(
                  child: PrimaryButton(
                    buttonText: 'Sign Up',
                  ),
                  onTap: () {
                    registerNewUser(context);
                  }),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: PrimaryColor,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ProgressDialog(
              message: "Registering, Please wait...",
            );
          });

      final User firebaseUser = (await _firebaseAuth
              .createUserWithEmailAndPassword(
                  email: emailTextEditingController.text,
                  password: passwordTextEditingController.text)
              .catchError((errMsg) {
        Navigator.pop(context);
        displayToastMessage("Error: " + errMsg.toString(), context);
      }))
          .user;

      if (firebaseUser != null) //user created
      {
        //save user info to database
        Map userDataMap = {
          "id": firebaseUser.uid,
          "name": nameTextEditingController.text.trim(),
          "email": emailTextEditingController.text.trim(),
          // "phone": phoneTextEditingController.text.trim(),
        };

        usersRef.child(firebaseUser.uid).set(userDataMap);
        displayToastMessage(
            "Congratulations, your account has been created.", context);

        Navigator.pushNamedAndRemoveUntil(
            context, NavigationBarBottom.idScreen, (route) => false);
      } else {
        Navigator.pop(context);
        //error occured - display error msg
        displayToastMessage("New user account has not been Created.", context);
      }
    } catch (e) {
      displayToastMessage("Error: " + e.toString(), context);
    }
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
