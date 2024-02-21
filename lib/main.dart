import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/home.dart';

import 'package:flutter_project/screens/login.dart';
import 'package:flutter_project/screens/signup.dart';
import 'package:flutter_project/theme.dart';
import 'package:flutter_project/widgets/navigation_bar.dart';

import 'package:native_state/native_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Firebase.initializeApp(
  //     options: FirebaseOptions(
  //   apiKey: "AIzaSyCnB3ofPsMi-h7Ie6viPSZmbKZJfoMBCXg",
  //   appId: "1:705607858092:android:949d33e5aa2a4289ac2c09",
  //   messagingSenderId: "705607858092",
  //   projectId: "fanalprojectandroid",
  // ));
  runApp(SavedState(child: MyApp()));
}

DatabaseReference usersRef =
    FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'root',
      theme: ThemeData(
        fontFamily: "Inder",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? LoginScreen.idScreen
          //: GettingStartedScreen.idScreen,

          : NavigationBarBottom.idScreen,
      routes: {
        NavigationBarBottom.idScreen: (context) => NavigationBarBottom(),
        SignUpScreen.idScreen: (context) => SignUpScreen(context),
        LoginScreen.idScreen: (context) => LoginScreen(),

        HomeScreen.idScreen: (context) => HomeScreen(),

        // PickerDemo.idScreen: (context) => PickerDemo()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
