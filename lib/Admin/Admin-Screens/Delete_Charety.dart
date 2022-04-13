// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/Admin/admain-screen.dart';
import 'package:hello/Widget/GridTile.dart';

class DeleteCharety extends StatefulWidget {
  const DeleteCharety({Key? key}) : super(key: key);

  @override
  _DeleteCharetyState createState() => _DeleteCharetyState();
}

class _DeleteCharetyState extends State<DeleteCharety> {
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
                      "Delete Charety",
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
      FirebaseFirestore.instance.collection("Charity").snapshots();
  @override
  Widget build(BuildContext context) {
    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
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
// data.size  data.docs[index]["Name"]
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0),
          itemCount: data.size,
          itemBuilder: (_, index) {
            return BuildGrid(
              title: data.docs[index]["Name"],
              img:data.docs[index]["Photo URL"] ,
              tap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    data.docs[index]["Name"],
                    style: const TextStyle(color: Colors.black87, fontSize: 22),
                  ),
                  // ignore: sized_box_for_whitespace
                  content: Container(
                    
                    height: heightScreen * 0.22,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Address :- ',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(data.docs[index]["Address"]),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text(
                                  " Email :- ",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(data.docs[index]["Email"]),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text(
                                  "Phone :- ",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(data.docs[index]["Phone"]),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text(
                                  "License Number :- ",
                                  style: TextStyle(
                                    
                                      color: Colors.black87,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(data.docs[index]["License Numbaer"],
                                style: const TextStyle(fontSize: 15),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ignore: avoid_unnecessary_containers
                        Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Back',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                        ),
                        // ignore: avoid_unnecessary_containers
                        Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {
                              data.docs[index].reference.delete().whenComplete(
                                  () => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AdmainHome())));
                            },
                            child: const Text(
                              'Delete',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
