// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/Admin/Admin-Screens/Availabale%20Items/Something.dart';
import 'package:hello/DataBase/Admin-DB/CharityNeed.dart';
import 'package:hello/Widget/GridTile.dart';

class AvailableDonation extends StatefulWidget {
  const AvailableDonation({Key? key}) : super(key: key);

  @override
  _AvailableDonationState createState() => _AvailableDonationState();
}

class _AvailableDonationState extends State<AvailableDonation> {
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
                      "Available Donation",
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

// ignore: must_be_immutable
class BuildContainer extends StatelessWidget {
  BuildContainer({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> charity =
      FirebaseFirestore.instance.collection("Donate Something").snapshots();
  TextEditingController nameCharityController = TextEditingController()
    ..text = '';

  void uploadToFireBase({String? name, dynamic img}) {
    ChAvailableItem().uploadData(
        nameCharity: nameCharityController.text, name: name, photoURL: img);
  }

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
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0),
          itemCount: data.size,
          itemBuilder: (context, index) {
            return BuildGrid(
              title: data.docs[index]["Item Type"],
              img: data.docs[index]["Photo Url"],
              tap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Something(items: data.docs[index],),
                          )),
            );
          },
        );
      },
    );
  }
}