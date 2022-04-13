// ignore_for_file: file_names, implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello/DataBase/Charity-DB/charity-benefit-requist.dart';
import 'package:hello/Views/Charity/Login/Helper-Login/Helpers-Function.dart';
import 'package:hello/Widget/Login-Filed.dart';
import 'package:hello/language/Generated/key-lang.dart';

// ignore: camel_case_types
class CahrityBenefitRequist extends StatefulWidget {
  const CahrityBenefitRequist({Key? key}) : super(key: key);

  @override
  _CahrityBenefitRequistState createState() => _CahrityBenefitRequistState();
}

class _CahrityBenefitRequistState extends State<CahrityBenefitRequist> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String charityName =" ";
  String desired = " ";
  String descrip = " ";
  TextEditingController donationEditingController = TextEditingController()
    ..text = '';
  TextEditingController descEditingController = TextEditingController()
    ..text = '';

    void getUserName(){
      HelpersFunction.getUserNameSharedPreference().then(
        (value) {
          setState(() {
            charityName = value!;
          });
        });
    }

   @override
  void initState() {
    getUserName();
    super.initState();
  }


  void uploadToCharityBage() {
    if (donationEditingController.text.isEmpty ||
        descEditingController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: KeyLang.PleaseChickYourInformation.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: KeyLang.YourInformationSended.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);
      AddCharityBenefit().uploadData(
        name: charityName.toString(),
          desired: donationEditingController.text,
          descr: descEditingController.text);
      deleteField();
    }
  }

  void deleteField() {
    donationEditingController.text = "";
    descEditingController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    var h =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,
      ),
      body: isLoading
          // ignore: avoid_unnecessary_containers
          ? Container(
              child: const Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
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
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: Column(
                          children: <Widget>[
                             Text(
                              KeyLang.BenefitRequist.tr(),
                              style:const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: h * 0.1),
                            Form(
                              key: _formKey,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: h * 0.03),
                                    LoginField(
                                      controller: donationEditingController,
                                      labelText: KeyLang.DesiredPurpose.tr(),
                                      keyboardType: TextInputType.text,
                                    ),
                                    SizedBox(height: h * 0.01),
                                    LoginField(
                                      controller: descEditingController,
                                      labelText: KeyLang.DescriptionForItem.tr(),
                                      keyboardType: TextInputType.text,
                                    ),

                                    SizedBox(height: h * 0.01),
                                    // ignore: sized_box_for_whitespace
                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      height: 55,
                                      width: double.infinity,
                                      // ignore: deprecated_member_use
                                      child: RaisedButton(
                                        color: Colors.teal,
                                        onPressed: () =>
                                            {uploadToCharityBage(),descrip=descEditingController.text,desired=donationEditingController.text},
                                        child:  Text(
                                          KeyLang.SEND.tr(),
                                          style:const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

