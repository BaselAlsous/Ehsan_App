// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/Views/Talabat/Talpat-Screen/charity-requist-talabat.dart';
import 'package:hello/language/Generated/key-lang.dart';

class Talabat extends StatefulWidget {
  const Talabat({Key? key}) : super(key: key);

  @override
  _MyCustomUIState createState() => _MyCustomUIState();
}

class _MyCustomUIState extends State<Talabat>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;

  @override
  void initState() {
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
    var h = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
                      Container(
                        height: h * 0.12,
                        decoration: const BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                      ),
          ListView(
            physics:
               const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
               SizedBox(
                    height: h * 0.01,
                  ),
                    Center(
                      child: Text(
                      KeyLang.Talabat.tr(),
                      style:  GoogleFonts.notoSans(
                       fontSize: 25,
                       fontWeight: FontWeight.bold,
                       color: Colors.white,
                   ),
                  ),
                    ),
                  SizedBox(
                    height: h * 0.16,
                  ),
              cards(),
              SizedBox(height: _w / 13),
              cards2(),
              SizedBox(height: _w / 13),
              cards3(),
            ],
          ),
        ],
      ),
    );
  }

  Widget cards() {
    double _w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
        child: InkWell(
          enableFeedback: true,
          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const talbElthaq()));},
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
                      backgroundImage: const AssetImage('asset/image/Requst/Requst.jpg')
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: _w / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(
                          child: Text(
                            KeyLang.CharityEnrollment.tr(),
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

  Widget cards2() {
    AlignmentDirectional.center;
    double _w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
        child: InkWell(
          enableFeedback: true,
          onTap: () { Navigator.pushNamed(context, '/talbmohtaj' );},
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            margin: EdgeInsets.fromLTRB(_w / 20, _w / 20, _w / 20, 0),
            padding: EdgeInsets.all(_w / 20),
            height: _w / 4.4,
            width: _w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const  Color(0xffEDECEA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.blue.withOpacity(.1),
                    radius: _w / 15,
                      backgroundImage:const AssetImage('asset/image/Requst/Requst.jpg')
                    ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: _w / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(
                          child: Text(
                                KeyLang.NeedyEnrollment.tr(),
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
  Widget cards3() {
    AlignmentDirectional.center;
    double _w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
        child: InkWell(
          enableFeedback: true,
          onTap: () {Navigator.pushNamed(context, '/talbEstfada' );},
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
                   backgroundImage: const AssetImage('asset/image/Requst/Requst.jpg')
                    ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: _w / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(
                          child: Text(
                            KeyLang.NeedBenefit.tr(),
                            textScaleFactor: 1.6,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
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
