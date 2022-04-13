// ignore_for_file: file_names, implementation_imports

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/Views/Charity/Screen-Charity/available-page.dart';
import 'package:hello/Widget/GridTile.dart';
import 'package:hello/language/Generated/key-lang.dart';

class AvailableSomethingItems extends StatelessWidget {
  final Future requist;
  final QuerySnapshot searchResultEnorllSnapshot;

  const AvailableSomethingItems({
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
                      KeyLang.MyItems.tr(),
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
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.0,
                                  crossAxisSpacing: 20.0,
                                  mainAxisSpacing: 20.0),
                          itemCount: searchResultEnorllSnapshot.docs.length,
                          itemBuilder: (_, index) {
                            return BuildGrid(
                              title: searchResultEnorllSnapshot.docs[index]
                                  ["Name"],
                              img: searchResultEnorllSnapshot.docs[index]
                                  ["Photo URL"],
                              tap: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    searchResultEnorllSnapshot.docs[index]
                                        ["Name"],
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
                                          child: Text(
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
