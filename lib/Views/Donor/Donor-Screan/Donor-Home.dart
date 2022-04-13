// ignore_for_file: file_names, implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/Widget/Build-ProfilDonor.dart';
import 'package:hello/language/Generated/key-lang.dart';

class DonorHome extends StatefulWidget {
  const DonorHome({Key? key}) : super(key: key);

  @override
  _DonorHomeState createState() => _DonorHomeState();
}

class _DonorHomeState extends State<DonorHome> {
  void selectPage(index) {
    Navigator.of(context)
        .pushNamed(index == 0 ? '/CashDonor' : '/SomthingDonate');
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
                        padding: EdgeInsets.all(heightScreen * 0.03),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Container(
                        margin:  EdgeInsets.all(heightScreen * 0.03),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    KeyLang.Donor.tr(),
                    style: GoogleFonts.notoSerif(
                      color: Colors.white,
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                      BuildProfile(
                          title: KeyLang.CashDonation.tr(),
                          onTap: () => selectPage(0),
                          image: 'asset/image/Custem/cash.jpg',
                        ),
                      BuildProfile(
                          title: KeyLang.DonateSomething.tr(),
                          onTap: () => selectPage(1),
                          image: 'asset/image/Custem/something.jpg',
                        )
                    ],),
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
