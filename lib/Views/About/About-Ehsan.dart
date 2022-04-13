// ignore_for_file: file_names, implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/language/Generated/key-lang.dart';

class MyCustomWidget extends StatefulWidget {
  const MyCustomWidget({Key? key}) : super(key: key);

  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  @override
  Widget build(BuildContext context) {
        var h = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Scaffold(
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
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          ),
           Column(children:  [
                    SizedBox(
                    height: h * 0.03,
                  ),
                    Text(
                    KeyLang.Ehsan.tr(),
                    style:  GoogleFonts.notoSans(
                     fontSize: 25,
                     fontWeight: FontWeight.bold,
                     color: Colors.white,
                   ),
                  ),
                  SizedBox(
                    height: h * 0.1,
                  ),
              const AnimCard(
              Colors.teal,
              '',
              '',
              '',
            ),
           ],)
          ],
        ));
  }
}

class AnimCard extends StatefulWidget {
  final Color color;
  final String num;
  final String numEng;
  final String content;

  // ignore: use_key_in_widget_constructors
  const AnimCard (this.color, this.num, this.numEng, this.content);

  @override
  _AnimCardState createState() => _AnimCardState();
}

class _AnimCardState extends State<AnimCard> {
  var padding = 150.0;
  var bottomPadding = 0.0;

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPadding(
            padding: EdgeInsets.only(top: padding, bottom: bottomPadding),
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastLinearToSlowEaseIn,
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: CardItem(
                widget.color,
                widget.num,
                widget.numEng,
                widget.content,
                () {
                  setState(() {
                    padding = padding == 0 ? 150.0 : 0.0;
                    bottomPadding = bottomPadding == 0 ? 150 : 0.0;
                  });
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 20, left: 20, top: 200),
              height: 180,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2), blurRadius: 30)
                ],
                color: Colors.grey.shade200.withOpacity(1.0),
                borderRadius: const
                    BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.blue.withOpacity(.1),
                  radius: 50,
                  backgroundImage: const AssetImage('asset/image/SplashPage/splash.jpg'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final Color color;
  final String num;
  final String numEng;
  final String content;
  final Function()? onTap;

  // ignore: use_key_in_widget_constructors
  const CardItem(this.color, this.num, this.numEng, this.content, this.onTap);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        height: 220,
        width: width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: const Color(0xff000000).withOpacity(0.2), blurRadius: 25),
          ],
          color: color.withOpacity(1.0),
          borderRadius:const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25,top: 10,right: 10,left: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                Text(
                  KeyLang.EhsanApp.tr(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'تطبيق أحسان  هو تطبيق  الكتروني لإدارة الجمعيات الخيرية بالمملكة الأردنيه الهاشميه  وتحويل الجمعية من ورقية الى جمعية الكترونية تتعامل الانظمة الالكترونية كما يسهل تطبيق احسان  تواصل المستفيدين مع الجمعية حيث يمكن للمستفيد متابعة طلباته و احتياجاته من خلال التطبيق  الالكتروني للجمعية وانشاء الطلبات الجديده ومتابعتها ،يعد تطبيق أحسان للتبرعات الحل الأسهل والأمثل لإيصال المتبرع إلى المحتاج في شتى مناطق ومدن المملكة من خلال عملية تبرع آمنة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,  
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}