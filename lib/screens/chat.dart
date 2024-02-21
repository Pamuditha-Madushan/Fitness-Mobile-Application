import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/massage.dart';
import 'package:flutter_project/theme.dart';
import 'login.dart';

class chatpage extends StatefulWidget {
  final String email;
  chatpage({this.email});
  @override
  _chatpageState createState() => _chatpageState(email: email);
}

class _chatpageState extends State<chatpage> {
  final String email;
  _chatpageState({this.email});

  final fs = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController message = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 35),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 270),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                      ),

                      color: BlackColor,
                      //to go back
                      onPressed: () => Navigator.of(context).pop(),
                      // onPressed: () {},
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: const Text(
                      'CHAT',
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
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.79,
                    child: messages(
                      email: email,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: message,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: PrimaryColor,
                            hintText: 'message',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: PrimaryColor),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: PrimaryColor),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {},
                          onSaved: (value) {
                            message.text = value;
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (message.text.isNotEmpty) {
                            fs.collection('Messages').doc().set({
                              'message': message.text.trim(),
                              'time': DateTime.now(),
                              'email': widget.email,
                            });

                            message.clear();
                          }
                        },
                        icon: Icon(Icons.send_sharp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
