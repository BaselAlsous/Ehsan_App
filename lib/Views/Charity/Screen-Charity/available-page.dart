// ignore_for_file: file_names, implementation_imports

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/Views/Charity/Login/Helper-Login/Helpers-Function.dart';
import 'package:hello/Views/Charity/Screen-Charity/Available-Screens/Cash_donation.dart';
import 'package:hello/Views/Charity/Screen-Charity/Available-Screens/Something_item.dart';
import 'package:hello/Widget/Build-ProfilDonor.dart';
import 'package:hello/language/Generated/key-lang.dart';

class AvailablePage extends StatefulWidget {
  const AvailablePage({Key? key}) : super(key: key);

  @override
  _AvailablePageState createState() => _AvailablePageState();
}

class _AvailablePageState extends State<AvailablePage> {
  String myName = '';
  late QuerySnapshot searchResultAvailableItems;
  late QuerySnapshot searchResultAvailableCash;
  
  void getMyName() {
    HelpersFunction.getUserNameSharedPreference().then((value) => setState(
          () {
            myName = value!;
          },
        ));
  }

   Future fllterAvailableCash() async {
    await FirebaseFirestore.instance
        .collection("Charity Available Cash")
        .where('Name Charity', isEqualTo: myName)
        .get()
        .then(
          (value) => setState(
            () {
              searchResultAvailableCash = value;
            },
          ),
        );
  }

  Future fllterAvailableItems() async {
    await FirebaseFirestore.instance
        .collection("Charity Available Item")
        .where('Name Charity', isEqualTo: myName)
        .get()
        .then(
          (value) => setState(() {
            searchResultAvailableItems = value;
          }),
        );
  }



  @override
  void initState() {
    fllterAvailableCash();
    fllterAvailableItems();
    getMyName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    var widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: heightScreen * 0.3,
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
                        onPressed: () => Navigator.of(context).pop(),
                      ),
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
                    myName,
                    style: GoogleFonts.notoSerif(
                      color: Colors.white,
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  BuildProfile(
                    title: KeyLang.MyItems.tr(),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AvailableSomethingItems(
                          requist: fllterAvailableItems(),
                          searchResultEnorllSnapshot:
                              searchResultAvailableItems,
                        ),
                      ),
                    ),
                    image: 'asset/image/Custem/cash.jpg',
                  ),
                  BuildProfile(
                    title: KeyLang.MyCash.tr(),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AvailableCashDonation(
                          requist: fllterAvailableCash(),
                          searchResultEnorllSnapshot: searchResultAvailableCash,
                        ),
                      ),
                    ),
                    image: 'asset/image/Custem/something.jpg',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
