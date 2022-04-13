// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/Views/Charity/Login/Helper-Login/Helpers-Function.dart';
import 'package:hello/Views/Charity/Login/Services/Authentication-Firebase.dart';
import 'package:provider/provider.dart';

class AdmainHome extends StatefulWidget {
  const AdmainHome({Key? key}) : super(key: key);

  @override
  _AdmainHomeState createState() => _AdmainHomeState();
}

class _AdmainHomeState extends State<AdmainHome> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final authService = Provider.of<AuthService>(context);

    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    var widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      // ignore: sized_box_for_whitespace
      body: Container(
        height: heightScreen,
        child: Stack(
          children: [
            Container(
              height: heightScreen * 0.3,
              width: widthScreen,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(140),
                    bottomRight: Radius.circular(140)),
                color: Colors.teal,
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: const EdgeInsets.all(10),
                        child: InkWell(
                          child: const Icon(Icons.logout , color: Colors.white,),
                          onTap: () {
                            HelpersFunction.saveUserLoggedInSharedPreference(false);
                            AuthService().signOut();
                             Navigator.pop(context);},
                        )),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    ],
                ),
                Text(
                  "Admain home",
                  style: GoogleFonts.notoSerif(
                    color: Colors.white,
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: heightScreen * 0.2,
                      ),
                     Padding(
                        padding: EdgeInsets.only(
                            top: heightScreen * 0.02,
                            right: widthScreen * 0.09,
                            left: widthScreen * 0.09),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          elevation: 10.0,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/AdminCharRequist');
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 25),
                                  width: widthScreen * 0.7,
                                  child: Text(
                                    'Charity Requist',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.notoSerif(
                                      color: Colors.indigo[900],
                                      fontSize: 19,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: heightScreen * 0.02,
                            right: widthScreen * 0.09,
                            left: widthScreen * 0.09),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          elevation: 10.0,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/CharityNeed');
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 25),
                                  width: widthScreen * 0.7,
                                  child: Text(
                                    'Charity Needs',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.notoSerif(
                                      color: Colors.indigo[900],
                                      fontSize: 19,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: heightScreen * 0.02,
                            right: widthScreen * 0.09,
                            left: widthScreen * 0.09),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          elevation: 10.0,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/AvailableDonation');
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 25),
                                  width: widthScreen * 0.7,
                                  child: Text(
                                    'Available Donation',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.notoSerif(
                                      color: Colors.indigo[900],
                                      fontSize: 19,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: heightScreen * 0.02,
                            right: widthScreen * 0.09,
                            left: widthScreen * 0.09),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          elevation: 10.0,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/AvailableCash');
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 25),
                                  width: widthScreen * 0.7,
                                  child: Text(
                                    'Available Cash',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.notoSerif(
                                      color: Colors.indigo[900],
                                      fontSize: 19,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: heightScreen * 0.02,
                            right: widthScreen * 0.09,
                            left: widthScreen * 0.09),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          elevation: 10.0,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/deleteCharety');
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 25),
                                  width: widthScreen * 0.7,
                                  child: Text(
                                    'Delete Charety',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.notoSerif(
                                      color: Colors.indigo[900],
                                      fontSize: 19,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: heightScreen * 0.02,
                            right: widthScreen * 0.09,
                            left: widthScreen * 0.09),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          elevation: 10.0,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/Feedback');
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 25),
                                  width: widthScreen * 0.7,
                                  child: Text(
                                    'Feedback',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.notoSerif(
                                      color: Colors.indigo[900],
                                      fontSize: 19,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
