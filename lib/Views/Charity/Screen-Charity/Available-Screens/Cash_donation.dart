// ignore_for_file: file_names, implementation_imports

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/Views/Charity/Screen-Charity/available-page.dart';
import 'package:hello/language/Generated/key-lang.dart';

class AvailableCashDonation extends StatelessWidget {
  final Future requist;
  final QuerySnapshot searchResultEnorllSnapshot;

  const AvailableCashDonation({
    Key? key,
    required this.requist,
    required this.searchResultEnorllSnapshot,
  }) : super(key: key);

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
                      KeyLang.MyCash.tr(),
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
                    child: FutureBuilder(
                      future: requist,
                      builder: (_, snapshot) {
                        return ListView.builder(
                          itemCount: searchResultEnorllSnapshot.docs.length,
                          itemBuilder: (_, index) {
                            return BuildCard1(
                              title:  KeyLang.Ihavethismuchmoney.tr(),
                              Feature: searchResultEnorllSnapshot.docs[index]
                                  ["Donation Amount"],
                              tap: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title:  Text(
                                    KeyLang.Ihavethismuchmoney.tr(),
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 17),
                                  ),
                                  content: Text(
                                    searchResultEnorllSnapshot.docs[index]
                                        ["Donation Amount"],
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 17),
                                  ),
                                  actions: [
                                    Center(
                                      // ignore: avoid_unnecessary_containers
                                      child: Container(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                          onPressed: () {
                                            searchResultEnorllSnapshot
                                                .docs[index].reference
                                                .delete()
                                                .whenComplete(() =>
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const AvailablePage())));
                                          },
                                          child:  Text(
                                            KeyLang.Delete.tr(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
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
