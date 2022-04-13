// ignore_for_file: file_names, implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/Views/Charity/Login/Helper-Login/Helpers-Function.dart';
import 'package:hello/Widget/Card-HomePage.dart';
import 'package:hello/Widget/Drawer.dart';
import 'package:hello/language/Generated/key-lang.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool? userIsLoggedIn;
  // ignore: prefer_final_fields
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getUserLoggedInState();
    super.initState();
  }




  getUserLoggedInState() async {
    await HelpersFunction.getUserLoggedInSharedPreference()
        .then((value) => setState(() {
              userIsLoggedIn = value;
            }));
  }


  @override
  Widget build(BuildContext context) {
    // ignore: unused_element
    void selectRequest(value) {
      Navigator.of(context).pushNamed(value == 3
          ? '/About'
          : value == 2
              ? '/Talbat'
              : value == 0
                  ? '/DonorHome'
                  : "1");
    }


void userlog () {
      Navigator.of(context).pushNamed( userIsLoggedIn != null
        ? userIsLoggedIn == true
          ? '/Charity': '/SignIn': '/SignIn' );
    }

    var heightScreen =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _globalKey,
      drawer: const MyDrawer(),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: heightScreen * 0.2,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    color: Colors.teal,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding:  EdgeInsets.symmetric(horizontal: widthScreen * 0.01 , vertical: heightScreen*0.009),
                            child: IconButton(
                              onPressed: () =>
                                  _globalKey.currentState!.openDrawer(),
                              icon: const Icon(
                                Icons.menu,
                                size: 40,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                    Text(KeyLang.HomePage.tr(),
                        style: GoogleFonts.notoSans(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    // SizedBox(
                    //   height: heightScreen * 0.02,
                    // ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: widthScreen * 0.04 , vertical: heightScreen*0.02),
                      child: CardHorizontal(
                          title: KeyLang.Donor.tr(),
                          tap: () => selectRequest(0),
                          img: "asset/image/Custem/m.jpg",
                          cta: KeyLang.Viwe.tr()),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.04 , vertical: heightScreen*0.02),
                      child: CardHorizontal(
                          title: KeyLang.Charity.tr(),
                          tap: () => userlog(),
                          img: "asset/image/home/j.png",
                          cta: KeyLang.Viwe.tr()),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: widthScreen * 0.04 , vertical: heightScreen*0.02),
                      child: CardHorizontal(
                          title: KeyLang.Talabat.tr(),
                          tap: () => selectRequest(2),
                          img: "asset/image/Requst/t.png",
                          cta: KeyLang.Viwe.tr()),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: widthScreen * 0.04 , vertical: heightScreen*0.02),
                      child: CardHorizontal(
                        title: KeyLang.Ehsan.tr(),
                        tap: () => selectRequest(3),
                        img: "asset/image/SplashPage/splash.jpg",
                        cta: KeyLang.Viwe.tr(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
