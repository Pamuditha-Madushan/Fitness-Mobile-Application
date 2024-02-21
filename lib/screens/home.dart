import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/all_users.dart';
import 'package:flutter_project/screens/cart_screen.dart';
import 'package:flutter_project/screens/chat.dart';
import 'package:flutter_project/screens/faverite_screen.dart';
import 'package:flutter_project/screens/login.dart';
import 'package:flutter_project/screens/workout_plans.dart';
import 'package:flutter_project/theme.dart';

import 'package:flutter_project/widgets/progress_dialog.dart';

class HomeScreen extends StatefulWidget {
  static const String idScreen = "home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userinf;
  String useremail;
  void initState() {
    super.initState();
    getCurrentOnlineUserInfo();
    getCurrentOnlineUserInfo1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 0.0),
                      child: Container(
                        child: IconButton(
                          icon: Icon(Icons.shopping_cart_outlined),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartScreen(userinf)));
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 158.0),
                      child: Container(
                        child: IconButton(
                          icon: Icon(Icons.favorite_border_outlined),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        faVoriteScreen(userinf)));
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 0.0),
                      child: Text(
                        'WELCOME',
                        style: TextStyle(
                          fontSize: 24,
                          color: PrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 220,
                child: ClipRRect(
                  child: Image.asset('images/wp5339178.jpg'),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 10),
                child: Row(
                  children: [
                    const Text(
                      "Services",
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(children: [
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: (() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => workoutPlns()));
                  }),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    shadowColor: PrimaryColor,
                    color: WhiteColor,
                    child: SizedBox(
                      width: 150,
                      height: 170,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 15),
                        child: Column(
                          children: [
                            Image.asset('images/silver.png'),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Workout Plans',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green[900],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => chatpage(
                                  email: useremail,
                                )));
                  }),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    shadowColor: PrimaryColor,
                    color: WhiteColor,
                    child: SizedBox(
                      width: 150,
                      height: 170,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 15),
                        child: Column(
                          children: [
                            Image.asset('images/GettyImages-1049840750.jpg'),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Chat with Trainer',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green[900],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              // Padding(
              //   padding: const EdgeInsets.only(top: 25.0),
              //   child: Container(
              //     height: 220,
              //     child: ClipRRect(
              //       child: Image.asset('images/wp5339178.jpg'),
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void getCurrentOnlineUserInfo() async {
    User firebaseUser = FirebaseAuth.instance.currentUser;
    String userId = firebaseUser.uid;
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("users").child(userId);

    reference.once().then((DataSnapshot dataSnapShot) {
      if (dataSnapShot.value != null) {
        Users userCurrentInfo = Users.fromSnapshot(dataSnapShot);

        userinf = userCurrentInfo.id;
        return userinf;
      }
    });
  }

  void getCurrentOnlineUserInfo1() async {
    User firebaseUser = FirebaseAuth.instance.currentUser;
    String userId = firebaseUser.uid;
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("users").child(userId);

    reference.once().then((DataSnapshot dataSnapShot) {
      if (dataSnapShot.value != null) {
        Users userCurrentInfo = Users.fromSnapshot(dataSnapShot);

        useremail = userCurrentInfo.email;
        return useremail;
      }
    });
  }
}
