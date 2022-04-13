// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/DataBase/Feedback/feedback.dart';
import 'package:hello/Widget/Input-feedback.dart';
import 'package:hello/language/Generated/key-lang.dart';

class MyFeedback extends StatefulWidget {
  const MyFeedback({Key? key}) : super(key: key);

  @override
  _MyFeedbackState createState() => _MyFeedbackState();
}

class _MyFeedbackState extends State<MyFeedback> {
  final TextEditingController _controllerFeedback = TextEditingController()
    ..text = "";
  final TextEditingController _controllerName = TextEditingController()
    ..text = "";

  void uploadToFirebase() {
    if (_controllerFeedback.text.isEmpty || _controllerName.text.isEmpty) {
      Fluttertoast.showToast(
          msg: KeyLang.PleaseChickYourInformation.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.teal,
          textColor: Colors.teal,
          fontSize: 16.0);
    } else {
      try {
        AddFeedback().uploadData(
            name: _controllerName.text, feedback: _controllerFeedback.text);
          Fluttertoast.showToast(
          msg: KeyLang.Done.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.teal,
          textColor: Colors.teal,
          fontSize: 16.0);
         _controllerFeedback.text = "";
         _controllerName.text ="";
      } catch (e) {
          Fluttertoast.showToast(
          msg: KeyLang.PleaseChickYourInformation.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    var widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
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
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:  EdgeInsets.all(heightScreen * 0.02),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      KeyLang.Feedback.tr(),
                      style: GoogleFonts.notoSans(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: heightScreen * 0.019,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: widthScreen * 0.045,
                          vertical: heightScreen * 0.04),
                      child: Input2(
                        maxlength: 300,
                        maxline: 10,
                        keyboardType: TextInputType.emailAddress,
                        controller: _controllerFeedback,
                        placeholder: KeyLang.EnterYourFeedback.tr(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: heightScreen * 0.045),
                      child: Input2(
                        maxlength: 50,
                        keyboardType: TextInputType.text,
                        controller: _controllerName,
                        placeholder: KeyLang.YourName.tr(),
                      ),
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.teal,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10)),
                          onPressed: () {
                            uploadToFirebase();
                          },
                          child: Text(
                            KeyLang.SEND.tr(),
                            style: GoogleFonts.notoSerif(
                              color: Colors.white,
                              fontSize: 19,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    )
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
