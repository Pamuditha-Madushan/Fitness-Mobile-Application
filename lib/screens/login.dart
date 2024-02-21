import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/signup.dart';
import 'package:flutter_project/theme.dart';
import 'package:flutter_project/widgets/navigation_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  static const String idScreen = "login";
  const LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

//firebase implementation
final _auth = FirebaseAuth.instance;

// ignore: use_key_in_widget_constructors
class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    var titleText;
    // ignore: prefer_typing_uninitialized_variables
    var subTitle;
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
              SizedBox(
                height: 60,
              ),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Inder',
                ),
              ),

              // ignore: prefer_const_constructors
              SizedBox(
                height: 15,
              ),
              const Text(
                'Enter your emails and password',
                style: TextStyle(
                  fontSize: 15,
                  color: DarkGreyColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (value) {
                          emailController.text = value;
                        },
                        controller: emailController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return ("Please Enter Your Email");
                          }
                          //reg expression for email validation
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter Valid Email");
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: BlackColor,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {
                          passwordController.text = value;
                        },
                        controller: passwordController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          RegExp regExp = RegExp(r'^.{6,}$');
                          if (value.isEmpty) {
                            return (" password is required");
                          }
                          if (!regExp.hasMatch(value)) {
                            return ("please enter validate password");
                          }
                          return null;
                        },
                        obscureText: isObscure,
                        decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: const TextStyle(
                              color: BlackColor,
                            ),
                            focusedBorder: const UnderlineInputBorder(
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
              const SizedBox(
                height: 15,
              ),
              Container(
                child: const Text("Forget Password?"),
                alignment: Alignment.centerRight,
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                  child: PrimaryButton(
                    buttonText: 'Log In',
                  ),
                  onTap: () {
                    login(emailController.text, passwordController.text);
                  }),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(context),
                        ),
                      );
                    },
                    child: const Text(
                      'Signup',
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

  void login(String email, String password) async {
    if (_formKey.currentState.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successfull"),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavigationBarBottom(),
                    ),
                  )
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            Fluttertoast.showToast(
                msg: "Your email address appears to be malformed.");
            break;
          case "wrong-password":
            Fluttertoast.showToast(msg: "Your password is wrong.");
            break;
          case "user-not-found":
            Fluttertoast.showToast(msg: "User with this email doesn't exist.");
            break;
          case "user-disabled":
            Fluttertoast.showToast(
                msg: "User with this email has been disabled.");
            break;
          case "too-many-requests":
            Fluttertoast.showToast(msg: "Too many requests");
            break;
          case "operation-not-allowed":
            Fluttertoast.showToast(
                msg: "Signing in with Email and Password is not enabled.");
            break;
          default:
            Fluttertoast.showToast(msg: "An undefined Error happened.");
        }
        print(error.code);
      }
    }
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      emailController.dispose();
      passwordController.dispose();
      super.dispose();
    }
  }
}
