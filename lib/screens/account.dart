import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/login.dart';
import 'package:flutter_project/theme.dart';
import 'package:flutter_project/widgets/primary_button.dart';
import 'package:flutter_project/widgets/progress_dialog.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key key}) : super(key: key);

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Column(children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 0,
                      top: MediaQuery.of(context).size.height * 0.05,
                      right: MediaQuery.of(context).size.width * 0.03,
                      bottom: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      'images/wp5339178.jpg',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03,
                              top: 40,
                              right: 10,
                              bottom: 0),
                          child: Text(
                            'Afsar Hassen',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03,
                              top: MediaQuery.of(context).size.width * 0.1,
                              right: MediaQuery.of(context).size.width * 0.06,
                              bottom: 0),
                          child: const Icon(
                            Icons.edit_outlined,
                            color: PrimaryColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.03,
                          top: 0,
                          right: MediaQuery.of(context).size.width * 0.06,
                          bottom: 0),
                      child: Text(
                        'Imshuwa97@gmail.com',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            letterSpacing: 0.3),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Divider(
              color: ZambeziColor,
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SingleChildScrollView(
              //scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.01,
                ),
                child: Row(
                  children: [
                    Container(
                      child: Icon(Icons.shopping_bag_outlined),
                      width: 40,
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 0, top: 0, right: 0, bottom: 0),
                          child: const Center(
                            child: Text(
                              'Orders',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  letterSpacing: 0.3),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .53,
                              bottom: 0),
                          child: const Icon(
                            Icons.keyboard_arrow_right,
                            color: Color.fromARGB(255, 77, 76, 76),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Divider(
              color: ZambeziColor,
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SingleChildScrollView(
              //scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.01,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 0, top: 0, right: 0, bottom: 0),
                      child: Icon(Icons.contact_phone_outlined),
                      width: 40,
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 0, top: 0, right: 0, bottom: 0),
                          child: const Center(
                            child: Text(
                              'My Details',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  letterSpacing: 0.3),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .46,
                              bottom: 0),
                          child: const Icon(
                            Icons.keyboard_arrow_right,
                            color: Color.fromARGB(255, 77, 76, 76),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Divider(
              color: ZambeziColor,
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SingleChildScrollView(
              // scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.01,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 0, top: 0, right: 0, bottom: 0),
                      child: Icon(Icons.help_outline_sharp),
                      width: 40,
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 0, top: 0, right: 0, bottom: 0),
                          child: const Center(
                            child: Text(
                              'Help',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  letterSpacing: 0.3),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .57,
                              bottom: 0),
                          child: const Icon(
                            Icons.keyboard_arrow_right,
                            color: Color.fromARGB(255, 77, 76, 76),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Divider(
              color: ZambeziColor,
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SingleChildScrollView(
              //  scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.01,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 0, top: 0, right: 0, bottom: 0),
                      child: Icon(Icons.info_outline),
                      width: 40,
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 0, top: 0, right: 0, bottom: 0),
                          child: const Center(
                            child: Text(
                              'About',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  letterSpacing: 0.3),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .54,
                              bottom: 0),
                          child: const Icon(
                            Icons.keyboard_arrow_right,
                            color: Color.fromARGB(255, 77, 76, 76),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Divider(
              color: ZambeziColor,
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            InkWell(
                child: PrimaryButton(
                  buttonText: 'Log Out',
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();

                  Timer timer = Timer(Duration(milliseconds: 3000), () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  });
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return ProgressDialog(
                          message: "Please wait...",
                        );
                      }).then((value) {
                    // dispose the timer in case something else has triggered the dismiss.
                    timer?.cancel();
                    timer = null;
                  });
                }),
          ]),
        ),
      ),
    );
  }
}
