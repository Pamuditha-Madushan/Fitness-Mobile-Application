import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/models/all_users.dart';
import 'package:flutter_project/screens/product_view.dart';
import 'package:flutter_project/theme.dart';
import 'package:flutter_project/widgets/primary_button.dart';

class faVoriteScreen extends StatefulWidget {
  final String userinf;
  faVoriteScreen(this.userinf);

  @override
  faVoriteScreenState createState() => faVoriteScreenState();
}

class faVoriteScreenState extends State<faVoriteScreen> {
  void initState() {
    super.initState();
    setState(() {
      // counttotal();
    });

    // getCurrentOnlineUserInfo();
  }

  faVoriteScreenState();
  String userinf;
  double total = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 194.0),
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
                      'FAVORITES',
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
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('favorite')
                      .where('userid', isEqualTo: widget.userinf)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView(
                      children: snapshot.data.docs.map((document) {
                        return GestureDetector(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                        document['product_id'],
                                        document['name'],
                                        document['image'].toString(),
                                        document['price'],
                                        document['brand'],
                                        document['discription'],
                                        document['discription1'])));
                          }),
                          child: Card(
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            shadowColor: PrimaryColor,
                            child: Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 0,
                                        bottom: 0,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 300.0),
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.close,
                                              ),

                                              color: BlackColor,
                                              //to go back

                                              onPressed: () async {
                                                print(document.id);
                                                await FirebaseFirestore.instance
                                                    .collection("favorite")
                                                    .doc(document.id)
                                                    .delete();
                                              },
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: Image(
                                                    height: 70,
                                                    width: 70,
                                                    image: NetworkImage(
                                                        document['image']
                                                            .toString())),
                                              ),
                                              // Image.asset(
                                              //   'images/clipart-exercise-fitness-centre-19.png',
                                              //   height: 70,
                                              //   width: 70,
                                              // ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10, left: 10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      document['name'],
                                                      style: const TextStyle(
                                                          fontSize: 20),
                                                    ),

                                                    // Text(
                                                    //   document['user_id'],
                                                    //   style: const TextStyle(
                                                    //       fontSize: 22),
                                                    // ),
                                                    // Text(
                                                    //   document['discription'],
                                                    //   style: const TextStyle(
                                                    //       fontSize: 14),
                                                    // ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 180.0),
                                                      child: Text(
                                                        document['price']
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                PrimaryColor),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  // void counttotal() async {
  //   QuerySnapshot snap = await FirebaseFirestore.instance
  //       .collection('cart')
  //       .where("userid", isEqualTo: widget.userinf)
  //       .get();

  //   snap.docs.forEach((document) {
  //     double price = document['price'];
  //     total += document['price'];
  //     print(total);
  //     return total;
  //   });
  // }
}
