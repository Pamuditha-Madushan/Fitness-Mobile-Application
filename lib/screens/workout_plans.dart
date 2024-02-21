import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/screens/pdfview.dart';

import 'package:flutter_project/screens/product_view.dart';
import 'package:flutter_project/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class workoutPlns extends StatefulWidget {
  @override
  workoutPlnsState createState() => workoutPlnsState();
}

class workoutPlnsState extends State<workoutPlns> {
  void initState() {
    super.initState();
  }

  workoutPlnsState();

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
                    padding: const EdgeInsets.only(right: 121.0),
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
                      'WORKOUT PLANS',
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
                      .collection('files')
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
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ProductDetailsScreen(
                            //             document['id'],
                            //             document['name'],
                            //             document['image'].toString(),
                            //             document['price'],
                            //             document['brand'],
                            //             document['discription'],
                            //             document['discription1'])));
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
                                        bottom: 20,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       bottom: 8),
                                              //   child: Image(
                                              //       height: 70,
                                              //       width: 70,
                                              //       image: NetworkImage(
                                              //           document['image']
                                              //               .toString())),
                                              // ),
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

                                                    // Text(
                                                    //   document['discription'],
                                                    //   style: const TextStyle(
                                                    //       fontSize: 14),
                                                    // ),
                                                    // Padding(
                                                    //   padding:
                                                    //       const EdgeInsets.only(
                                                    //           left: 180.0),
                                                    //   child: Text(
                                                    //     document['price']
                                                    //         .toString(),
                                                    //     style: const TextStyle(
                                                    //         fontSize: 14,
                                                    //         color:
                                                    //             PrimaryColor),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 190.0),
                                                child: IconButton(
                                                    onPressed: () async {
                                                      print(document['pdf']);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  pdfview(document[
                                                                      'pdf'])));
                                                    },
                                                    icon: Icon(
                                                        Icons.remove_red_eye)),
                                              )
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
