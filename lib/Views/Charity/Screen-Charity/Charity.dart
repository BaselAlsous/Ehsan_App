// ignore_for_file: file_names, implementation_imports

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/Views/Charity/Login/Helper-Login/Helpers-Function.dart';
import 'package:hello/Views/Charity/Login/Services/Authentication-Firebase.dart';
import 'package:hello/Views/Charity/Screen-Charity/available-page.dart';
import 'package:hello/Views/Charity/Screen-Charity/benefit-page%20.dart';
import 'package:hello/Views/Charity/Screen-Charity/enrollment_requist_page.dart';
import 'package:hello/language/Generated/key-lang.dart';

class Charity extends StatefulWidget {
  const Charity({Key? key}) : super(key: key);

  @override
  _MyCustomUIState createState() => _MyCustomUIState();
}

class _MyCustomUIState extends State<Charity>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;
  String charityName = "";
   QuerySnapshot? searchResultEnrollmentReqyist;
   QuerySnapshot? searchResultBenefitReqyist;

 
  void getNameCharity() {
    HelpersFunction.getUserNameSharedPreference().then(
      (value) => setState(
        () {
          charityName = value!;
        },
      ),
    );
  }

  Future fllterEnrollment() async {
    await FirebaseFirestore.instance
        .collection("Enrollment Requist")
        .where('Charity Name', isEqualTo: charityName)
        .get()
        .then(
          (value) => setState(
            () {
              searchResultEnrollmentReqyist = value;
            },
          ),
        );
  }

  Future fllterBenefit() async {
    await FirebaseFirestore.instance
        .collection("Benefit Requist")
        .where('Charity Name', isEqualTo: charityName)
        .get()
        .then(
          (value) => setState(
            () {
              searchResultBenefitReqyist = value;
            },
          ),
        );
  }



  @override
  void initState() {
    getNameCharity();
    fllterBenefit();
    fllterEnrollment();
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: 0, end: -30)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            HelpersFunction.saveUserLoggedInSharedPreference(false);
            AuthService().signOut();
            Navigator.pop(context);
            Navigator.pushNamed(context, '/SignIn');
          },
        ),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/MyHomePage'),
              icon: const Icon(Icons.home))
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: h * 0.12,
            decoration: const BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
          //  NavBar(),
          ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: h * 0.01,
              ),
              Center(
                child: Text(
                  KeyLang.Charity.tr(),
                  style: GoogleFonts.notoSans(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.1,
              ),
              SingleChildScrollView(
                child: Column(
                  // physics: const BouncingScrollPhysics(
                  //     parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    card1(),
                    SizedBox(height:  h * 0.015),
                    card2(),
                    SizedBox(height:  h * 0.015),
                    card3(),
                    SizedBox(height:  h * 0.015),
                    card4(),
                    SizedBox(height:  h * 0.015),
                  ],
                ),
              ),
            ],
          ),

          // top me rahna
        ],
      ),
    );
  }

  Widget card1() {
    double _w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
        child: InkWell(
          enableFeedback: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EnrillmentRequist(
                  requist: fllterEnrollment(),
                  searchResultEnorllSnapshot: searchResultEnrollmentReqyist!,
                ),
              ),
            );
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            margin: EdgeInsets.fromLTRB(_w / 20, _w / 20, _w / 20, 0),
            padding: EdgeInsets.all(_w / 20),
            height: _w / 4.4,
            width: _w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xffEDECEA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.withOpacity(.1),
                  radius: _w / 15,
                  backgroundImage:
                      const AssetImage('asset/image/Requst/Requst.jpg'),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: _w / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Center(
                          child: Text(
                            KeyLang.EnrollmentRequist.tr(),
                            textScaleFactor: 1.6,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(.7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.navigate_next_outlined)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget card2() {
    double _w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
        child: InkWell(
          enableFeedback: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BenefitPage(
                  requist: fllterBenefit(),
                  searchResultBenefitSnapshot: searchResultBenefitReqyist!,
                ),
              ),
            );
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            margin: EdgeInsets.fromLTRB(_w / 20, _w / 20, _w / 20, 0),
            padding: EdgeInsets.all(_w / 20),
            height: _w / 4.4,
            width: _w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xffEDECEA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.withOpacity(.1),
                  radius: _w / 15,
                  backgroundImage:
                      const AssetImage('asset/image/Requst/Requst.jpg'),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: _w / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Center(
                          child: Text(
                            KeyLang.BenefitRequist.tr(),
                            textScaleFactor: 1.6,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(.7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.navigate_next_outlined)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget card3() {
    double _w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
        child: InkWell(
          enableFeedback: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AvailablePage(),
              ),
            );
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            margin: EdgeInsets.fromLTRB(_w / 20, _w / 20, _w / 20, 0),
            padding: EdgeInsets.all(_w / 20),
            height: _w / 4.4,
            width: _w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xffEDECEA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.withOpacity(.1),
                  radius: _w / 15,
                  backgroundImage: const AssetImage('asset/image/home/1q.jpg'),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: _w / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Center(
                          child: Text(
                            KeyLang.AvailabeDonation.tr(),
                            textScaleFactor: 1.6,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(.7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.navigate_next_outlined)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget card4() {
    double _w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
        child: InkWell(
          enableFeedback: true,
          onTap: () {
            Navigator.pushNamed(context, '/CahrityBenefitRequist');
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            margin: EdgeInsets.fromLTRB(_w / 20, _w / 20, _w / 20, 0),
            padding: EdgeInsets.all(_w / 20),
            height: _w / 4.4,
            width: _w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xffEDECEA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.withOpacity(.1),
                  radius: _w / 15,
                  backgroundImage: const AssetImage('asset/image/home/1q.jpg'),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: _w / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Center(
                          child: Text(
                            KeyLang.SendRequist.tr(),
                            textScaleFactor: 1.6,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(.7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.navigate_next_outlined)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
