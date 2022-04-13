// ignore_for_file: file_names, implementation_imports

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/Views/Charity/Screen-Charity/Charity.dart';
import 'package:hello/Widget/GridTile.dart';
import 'package:hello/language/Generated/key-lang.dart';

class EnrillmentRequist extends StatefulWidget {
   final Future requist;
   final QuerySnapshot searchResultEnorllSnapshot;

  // ignore: use_key_in_widget_constructors
  const EnrillmentRequist(
      {required this.requist, required this.searchResultEnorllSnapshot});

  @override
  State<EnrillmentRequist> createState() => _EnrillmentRequistState();
}

class _EnrillmentRequistState extends State<EnrillmentRequist> {


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
                      KeyLang.EnrollmentRequist.tr(),
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
                      future: widget.requist,
                      builder: (_, snapshot){
                        return GridView.builder(
                          gridDelegate:const
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.0,
                                  crossAxisSpacing: 20.0,
                                  mainAxisSpacing: 20.0),
                          itemCount:
                              widget.searchResultEnorllSnapshot.docs.length,
                          itemBuilder: (_, index) {
                            return BuildEnrollmentGrid(
                                title: widget.searchResultEnorllSnapshot.docs[index]["Name"],
                                tap: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title:  Text(
                                    widget.searchResultEnorllSnapshot.docs[index]["Name"],
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 22),
                                  ),
                                  // ignore: sized_box_for_whitespace
                                  content:Container(
                                    height: heightScreen * 0.22,
                                    child:SingleChildScrollView(
                                      child: Column(
                                      children:   [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                                 Text("${KeyLang.SocialStatus.tr()} :- ",
                                                style:  const TextStyle(
                                                    color: Colors.black87, fontSize: 17 ,fontWeight: FontWeight.bold),),
                                                Text(widget.searchResultEnorllSnapshot.docs[index]["Social Status "]),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                                 Text(" ${KeyLang.Age.tr()} :- " ,style: const TextStyle(
                                                   color: Colors.black87, fontSize: 17 ,fontWeight: FontWeight.bold
                                                ),),
                                                Text(widget.searchResultEnorllSnapshot.docs[index]["Age"]),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                                 Text("${KeyLang.Address.tr()} :- " , style: const TextStyle(
                                                   color: Colors.black87, fontSize: 17 ,fontWeight: FontWeight.bold
                                                ),),
                                                Text(widget.searchResultEnorllSnapshot.docs[index]["Address"]),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                                 Text("${KeyLang.Phone.tr()} :- " ,style:const TextStyle(
                                                   color: Colors.black87, fontSize: 17 ,fontWeight: FontWeight.bold
                                                ),),
                                                Text( widget.searchResultEnorllSnapshot.docs[index]["Phone"]),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                            onPressed: () {
                                             Navigator.pop(context);
                                            },
                                            child:  Text(
                                              KeyLang.Back.tr(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17),
                                            ),
                                          ),
                                        ),
                                        // ignore: avoid_unnecessary_containers
                                        Container(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.red,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                            onPressed: () {
                                              widget.searchResultEnorllSnapshot
                                                  .docs[index].reference
                                                  .delete()
                                                  .whenComplete(() =>
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const Charity())));
                                            },
                                            child:  Text(
                                              KeyLang.Delete.tr(),
                                              style:const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17),
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
