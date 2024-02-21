import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/screens/product_view.dart';
import 'package:flutter_project/theme.dart';

class ShopScreen extends StatefulWidget {
  @override
  ShopScreenState createState() => ShopScreenState();
}

class ShopScreenState extends State<ShopScreen> {
  ShopScreenState();

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
                  Container(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: const Text(
                      'SHOP',
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
            Image.asset(
                'images/Choosing The Best Bodybuilding Supplements.png'),
            Flexible(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
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
                                        document['id'],
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
                                        top: 20,
                                        bottom: 5,
                                      ),
                                      child: Column(
                                        children: [
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
                                                    left: 10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      document['name'],
                                                      style: const TextStyle(
                                                          fontSize: 22),
                                                    ),
                                                    Text(
                                                      document['discription'],
                                                      style: const TextStyle(
                                                          fontSize: 14),
                                                    ),
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
}
