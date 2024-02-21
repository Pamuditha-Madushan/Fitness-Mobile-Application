import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/main.dart';
import 'package:flutter_project/models/all_users.dart';
import 'package:flutter_project/screens/cart_screen.dart';
import 'package:flutter_project/screens/faverite_screen.dart';
import 'package:flutter_project/screens/home.dart';
import 'package:flutter_project/screens/signup.dart';
import 'package:flutter_project/theme.dart';
import 'package:flutter_project/widgets/navigation_bar.dart';
import 'package:flutter_project/widgets/primary_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String pid;
  final String name;
  final String image;
  final double price;
  final String brand;
  final String discription;
  final String discription1;

  ProductDetailsScreen(this.pid, this.name, this.image, this.price, this.brand,
      this.discription, this.discription1);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String userinf;
  void initState() {
    super.initState();
    getCurrentOnlineUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColor,
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 28),
              child: Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.arrow_back, color: WhiteColor),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              )),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 38.0),
                child: Text(
                  widget.name,
                  style: TextStyle(fontSize: 24, color: WhiteColor),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 38.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price',
                        style: TextStyle(fontSize: 15, color: WhiteColor),
                      ),
                      Text(
                        widget.price.toString(),
                        style: TextStyle(fontSize: 24, color: WhiteColor),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Image.network(
                    widget.image,
                    height: 250,
                    width: 250,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 300,
            decoration: const BoxDecoration(
              color: WhiteColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0),
              ),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 200.0, top: 10),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 20, top: 0, right: 0, bottom: 0),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: const EdgeInsets.only(
                                    left: 21, top: 0, right: 20, bottom: 0),
                                child: const Center(
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        letterSpacing: 0.3),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 0, top: 0, right: 0, bottom: 0),
                                child: Icon(
                                  Icons.add,
                                  color: PrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            widget.discription1,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 320.0),
                  child: IconButton(
                      onPressed: (() {
                        insertdata1();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => faVoriteScreen(userinf)));
                      }),
                      icon: const Icon(Icons.favorite_border_outlined)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 0, bottom: 40),
                  child: InkWell(
                      child: PrimaryButton(
                        buttonText: 'ADD TO CART',
                      ),
                      onTap: () async {
                        displayToastMessage("Successfuly added", context);
                        getCurrentOnlineUserInfo();
                        insertdata();

                        print(userinf);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => CartScreen(userinf)));
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void insertdata() {
    FirebaseFirestore.instance.collection('cart').add({
      'name': widget.name,
      'product_id': widget.pid,
      'userid': userinf,
      'image': widget.image,
      'price': widget.price
    });
  }

  void insertdata1() {
    FirebaseFirestore.instance.collection('favorite').add({
      'name': widget.name,
      'product_id': widget.pid,
      'userid': userinf,
      'image': widget.image,
      'price': widget.price,
      'brand': widget.brand,
      'discription': widget.discription,
      'discription1': widget.discription1
    });
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
}
