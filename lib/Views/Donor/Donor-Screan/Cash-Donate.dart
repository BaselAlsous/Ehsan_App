// ignore_for_file: file_names, implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/DataBase/Donor-Db/cash.dart';
import 'package:hello/Widget/Input-feedback.dart';
import 'package:hello/language/Generated/key-lang.dart';

class CashDonor extends StatefulWidget {
  const CashDonor({Key? key}) : super(key: key);

  @override
  _CashDonorState createState() => _CashDonorState();
}

class _CashDonorState extends State<CashDonor> {
  bool _val = false;

  TextEditingController nameController = TextEditingController()..text = '';
  TextEditingController addressController = TextEditingController()..text = '';
  TextEditingController phoneController = TextEditingController()..text = '';
  TextEditingController donationController = TextEditingController()..text = '';

  void uploadToCharityBage() {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty ||
        donationController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: KeyLang.PleaseChickYourInformation.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (_val == false){
       Fluttertoast.showToast(
          msg: KeyLang.PleaseAgree.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);
    }else {
      Fluttertoast.showToast(
          msg: KeyLang.YourInformationSended.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);
      AddCashDonation().uploadData(
          name: nameController.text,
          phone: phoneController.text,
          address: addressController.text,
          donation: donationController.text);
         deleteField(); 
         Navigator.pop(context);
    }
  }

  void deleteField() {
    nameController.text = "";
    phoneController.text = "";
    addressController.text = "";
    donationController.text = "";
    _val = false ;
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
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          Navigator.of(context).pop();
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: const Icon(
                          Icons.attach_money_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      KeyLang.CashDonate.tr(),
                      style: GoogleFonts.notoSerif(
                        color: Colors.white,
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 24.0, right: 24.0, bottom: 32),
                    child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height * 0.12,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    KeyLang.EnterYourInformation.tr(),
                                    style: GoogleFonts.notoSerif(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.63,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              color: Colors.white,
                            ),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Input(
                                            keyboardType: TextInputType.name,
                                            controller: nameController,
                                            placeholder: KeyLang.YourName.tr(),
                                            prefixIcon: const Icon(
                                              Icons.person,
                                              color: Colors.teal,
                                            ),
                                          ),
                                          Input(
                                            keyboardType:
                                                TextInputType.streetAddress,
                                            controller: addressController,
                                            placeholder: KeyLang.Address.tr(),
                                            prefixIcon: const Icon(
                                              Icons.location_on,
                                              color: Colors.teal,
                                            ),
                                          ),
                                          Input(
                                            keyboardType: TextInputType.phone,
                                            controller: phoneController,
                                            placeholder: KeyLang.Phone.tr(),
                                            prefixIcon: const Icon(
                                              Icons.phone,
                                              color: Colors.teal,
                                            ),
                                          ),
                                          Input(
                                            keyboardType: TextInputType.phone,
                                            controller: donationController,
                                            placeholder: KeyLang.DonationAmount.tr(),
                                            prefixIcon: const Icon(
                                              Icons.attach_money_outlined,
                                              color: Colors.teal,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.5,
                                            child:
                                                Container(color: Colors.grey),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3.0, top: 0, bottom: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Checkbox(
                                                  value: _val,
                                                  onChanged: (value) =>
                                                      setState(
                                                          () => _val = value!),
                                                ),
                                                 Text(KeyLang.Iagreewithe.tr(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17)),
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context, '/About');
                                                    },
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 2),
                                                      child:  Text(
                                                          KeyLang.PrivacyPolicy.tr(),
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.teal,
                                                              fontSize: 17)),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: Center(
                                              // ignore: deprecated_member_use
                                              child: FlatButton(
                                                color: Colors.teal,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                child:  Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 16.0,
                                                      right: 16.0,
                                                      top: 12,
                                                      bottom: 12),
                                                  child: Text(KeyLang.SEND.tr(),
                                                      style:const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16.0)),
                                                ),
                                                onPressed: () {uploadToCharityBage();},
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
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
