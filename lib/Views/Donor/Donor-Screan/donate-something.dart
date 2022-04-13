// ignore_for_file: file_names, implementation_imports

import 'dart:io';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hello/language/Generated/key-lang.dart';
// ignore: library_prefixes
import 'package:path/path.dart' as Path;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/DataBase/Donor-Db/somtjing.dart';
import 'package:hello/Widget/Input-feedback.dart';

class SomthingDonate extends StatefulWidget {
  const SomthingDonate({Key? key}) : super(key: key);

  @override
  _SomthingDonateState createState() => _SomthingDonateState();
}

class _SomthingDonateState extends State<SomthingDonate> {
  bool _val = false;
  String? selectedType;
  File? file;
  String item = "none";
  // ignore: prefer_typing_uninitialized_variables
  var url;
  String filepath = 'ImageDonationSomthing';
  TextEditingController nameController = TextEditingController()..text = '';
  TextEditingController descController = TextEditingController()..text = '';
  TextEditingController addressController = TextEditingController()..text = '';
  TextEditingController phoneController = TextEditingController()..text = '';

  void uploadToCharityBage() {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty ||
        descController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: KeyLang.PleaseChickYourInformation.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (_val == false) {
      Fluttertoast.showToast(
          msg: KeyLang.PleaseAgree.tr(),
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
      AddDonateSomething().uploadData(
          name: nameController.text,
          phone: phoneController.text,
          address: addressController.text,
          discr: descController.text,
          photo: url,
          item: selectedType);
      deleteField();
      deleteImage();
      Navigator.pop(context);
    }
  }

  void deleteField() {
    nameController.text = "";
    phoneController.text = "";
    addressController.text = "";
    descController.text = "";
    selectedType = null;
    _val = false;
  }

  void deleteImage() {
    file = null;
  }

  Future selectImg() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));

    if (file == null) return;

    final fileName = Path.basename(file!.path);
    //final destination = '$filepath/$fileName';

    Reference storageReference =
        FirebaseStorage.instance.ref().child('$filepath/$fileName');
    UploadTask uploadTask = storageReference.putFile(file!);
    await uploadTask;

    await storageReference.getDownloadURL().then((fileURL) => setState(() {
          url = fileURL;
          // ignore: avoid_print
          print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
          // ignore: avoid_print
          print("I have a $url");
        }));
  }

  @override
  Widget build(BuildContext context) {
    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    var widthScreen = MediaQuery.of(context).size.width;

    List province = [
      KeyLang.MedicalTool.tr(),
      KeyLang.Clothes.tr(),
      KeyLang.Electricaldevices.tr(),
      KeyLang.Foodstuffs.tr(),
      KeyLang.Other.tr(),
    ];

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
                          Icons.add_box,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      KeyLang.DonateSomething.tr(),
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
                                    KeyLang.EnterDonatedItemInformation.tr(),
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
                                            keyboardType: TextInputType.text,
                                            maxline: 5,
                                            controller: descController,
                                            placeholder: KeyLang.DescriptionForItem.tr(),
                                            prefixIcon: const Icon(
                                              Icons.description,
                                              color: Colors.teal,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.teal,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(4),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(
                                                      Icons.add_box,
                                                      color: Colors.teal,
                                                    ),
                                                  ),
                                                  DropdownButton(
                                                    dropdownColor: Colors.white,
                                                    items: province
                                                        .map(
                                                          (value) =>
                                                              DropdownMenuItem(
                                                            child: Text(
                                                              value,
                                                              style:
                                                                  const TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        136,
                                                                        152,
                                                                        170,
                                                                        1.0),
                                                              ),
                                                            ),
                                                            value: value,
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged:
                                                        (selectedAccountType) {
                                                      setState(
                                                        () {
                                                          selectedType =
                                                              selectedAccountType
                                                                  .toString();
                                                          item = selectedType!;
                                                        },
                                                      );
                                                    },
                                                    value: selectedType,
                                                    isExpanded: false,
                                                    hint: Text(
                                                      KeyLang.ItemType.tr(),
                                                      style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            136, 152, 170, 1.0),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.5,
                                            child:
                                                Container(color: Colors.grey),
                                          ),
                                          SizedBox(
                                              height: 0.5,
                                              child: Container(
                                                color: Colors.grey,
                                              )),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding:const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text(KeyLang.AddItemphoto.tr(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w300))),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Center(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  primary: Colors.teal,
                                                ),
                                                child: const Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  selectImg();
                                                },
                                              ),
                                            ),
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
                                                  padding:const EdgeInsets.only(
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
                                                onPressed: () {
                                                  uploadToCharityBage();
                                                },
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

  // container({String? item ='none'}) {
  //   if (item == 'Electrical devices') {
  // String? a;
  // List devices = [
  //   "TV",
  //   "Refrigerator",
  //   "Washing Machine",
  //   "radio",
  //   "Others",
  // ];
  // return Padding(
  //   padding: const EdgeInsets.all(8.0),
  //   child: Container(
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //         color: Colors.teal,
  //       ),
  //       borderRadius: const BorderRadius.all(
  //         Radius.circular(4),
  //       ),
  //     ),
  //     child: Row(
  //       children: [
  //         const Padding(
  //           padding: EdgeInsets.all(8.0),
  //           child: Icon(
  //             Icons.add_box,
  //             color: Colors.teal,
  //           ),
  //         ),
  //         DropdownButton(
  //           dropdownColor: Colors.white,
  //           items:devices
  //               .map(
  //                 (value) => DropdownMenuItem(
  //                   child: Text(
  //                     value,
  //                     style: const TextStyle(
  //                       color: Color.fromRGBO(136, 152, 170, 1.0),
  //                     ),
  //                   ),
  //                   value: value,
  //                 ),
  //               )
  //               .toList(),
  //           onChanged: (selectedAccountType) {
  //             setState(
  //               () {
  //                 a = selectedAccountType.toString();
  //               },
  //             );
  //           },
  //           value: a,
  //           isExpanded: false,
  //           hint: const Text(
  //             "Item Type",
  //             style: TextStyle(
  //               color: Color.fromRGBO(136, 152, 170, 1.0),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // );
  //   } else if (item == 'Clothes') {
  //     return;
  //   } else if(item == 'none'){
  //     return null;
  //   }
  // }
}
