// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/Admin/Admin-Screens/Availabale%20Items/Cash.dart';

class AvailableCash extends StatefulWidget {
  const AvailableCash({Key? key}) : super(key: key);

  @override
  _AvailableCashState createState() => _AvailableCashState();
}

class _AvailableCashState extends State<AvailableCash> {
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
                      "Available Cash",
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
      FirebaseFirestore.instance.collection("Cash Donation").snapshots();
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
              title: data.docs[index]["Name"],
              Feature: data.docs[index]["Donation Amount"],
              tap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Cash(
                    items: data.docs[index],
                  ),
                ),
              ),
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
