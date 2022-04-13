// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CharityNeed extends StatefulWidget {
  const CharityNeed({Key? key}) : super(key: key);

  @override
  _CharityNeedState createState() => _CharityNeedState();
}

class _CharityNeedState extends State<CharityNeed> {
  @override
  Widget build(BuildContext context) {
    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    var widthScreen = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: heightScreen * 0.2,
              width: widthScreen,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                color: Colors.teal,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context)),
                      Container(
                        margin: const EdgeInsets.all(16),
                        child: const Icon(
                          Icons.assignment_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: heightScreen * 0.05),
                    child: Text(
                      "Charity Needs",
                      style: GoogleFonts.notoSerif(
                        color: Colors.white,
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Container(
                    height: heightScreen * 1,
                    margin: const EdgeInsets.symmetric(vertical: 21),
                    padding: EdgeInsets.symmetric(
                        vertical: heightScreen * 0.011, horizontal: 22),
                    child: BuildContainer(),
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

class BuildContainer extends StatelessWidget {
  BuildContainer({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> charity =
      FirebaseFirestore.instance.collection("Charity Benefit Requist").snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: charity,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("SomeThing Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        final data = snapshot.requireData;

        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            return BuildCard1(
              title: data.docs[index]["Charity Name"],
              Feature: data.docs[index]["Desired Purpose"],
              tap: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text(
                          data.docs[index]["Desired Purpose"],
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 17),
                        ),
                        content: Text(
                          data.docs[index]["Descreption For Item"],
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 17),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // ignore: avoid_unnecessary_containers
                              Container(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  onPressed: () {
                                    data.docs[index].reference
                                        .delete()
                                        .whenComplete(
                                            () => Navigator.pop(context));
                                  },
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                ),
                              ),
                          ],
                          ),
                        ],
                      )),
            );
          },
        );
      },
    );
  }
}

class BuildCard1 extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final String Feature;
  final Function()? tap;
  final String title;

  // ignore: use_key_in_widget_constructors, non_constant_identifier_names
  const BuildCard1({required this.title, required this.Feature, this.tap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      child: InkWell(
        onTap: tap,
        child: Card(
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          shadowColor: Colors.blueAccent,
          child: ListTile(
              title: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                  ),
                  child: Text(
                    title,
                    style: GoogleFonts.notoSerif(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onTap: tap,
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                    indent: 32.0,
                    endIndent: 32.0,
                  ),
                  Text(Feature,
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 17)),
                ],
              )),
        ),
      ),
    );
  }
}
