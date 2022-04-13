// ignore_for_file: file_names, library_prefixes, implementation_imports

import 'dart:io';

import 'package:easy_localization/src/public_ext.dart';
import 'package:hello/language/Generated/key-lang.dart';
import 'package:path/path.dart' as Path;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello/DataBase/Admin-DB/charity-requist.dart';
import 'package:hello/Widget/Login-Filed.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: camel_case_types
class talbElthaq extends StatefulWidget {
  const talbElthaq({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<talbElthaq> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  UploadTask? task;
  File? file;

  TextEditingController usernameEditingController = TextEditingController()
    ..text = '';
  TextEditingController emailEditingController = TextEditingController()
    ..text = '';
  TextEditingController phoneEditingController = TextEditingController()
    ..text = '';
  TextEditingController addressEditingController = TextEditingController()
    ..text = '';
  TextEditingController licenseEditingController = TextEditingController()
    ..text = '';

  // ignore: prefer_typing_uninitialized_variables
  var url;
  String filepath = 'CharityImage';

  void trasformToAdmin() async {
    if (usernameEditingController.text.isEmpty ||
        emailEditingController.text.isEmpty ||
        addressEditingController.text.isEmpty ||
        licenseEditingController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: KeyLang.PleaseChickYourInformation.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (phoneEditingController.text.length < 10) {
      Fluttertoast.showToast(
          msg: KeyLang.PleaseChickYourPhone.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (file == null) {
      Fluttertoast.showToast(
          msg: KeyLang.PleaseSelectYourPhoto.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      try {
        AddCharityRequist().uploadData(
          name: usernameEditingController.text,
          email: emailEditingController.text,
          phone: phoneEditingController.text,
          address: addressEditingController.text,
          license: licenseEditingController.text,
          photoURL: url,
        );
        Fluttertoast.showToast(
            msg: KeyLang.YourInformationSended.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            fontSize: 16.0);
        deleteField();
        deleteImage();
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  void deleteField() {
    usernameEditingController.text = "";
    emailEditingController.text = "";
    phoneEditingController.text = "";
    licenseEditingController.text = "";
    addressEditingController.text = "";
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
                              KeyLang.CharityEnrollmentRequist.tr(),
                              style: const TextStyle(
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
                                      labelText: KeyLang.YourName.tr(),
                                      controller: usernameEditingController,
                                      keyboardType: TextInputType.name,
                                      validator: (val) {
                                        return val!.isEmpty || val.length < 3
                                            ? "Enter Username 3+ characters"
                                            : null;
                                      },
                                    ),
                                    SizedBox(height: h * 0.01),
                                    LoginField(
                                      controller: phoneEditingController,
                                      labelText: KeyLang.Phone.tr(),
                                      keyboardType: TextInputType.phone,
                                      validator: (value) => value!.length < 11
                                          ? 'Your password must be larger than 8 characters'
                                          : null,
                                    ),
                                    SizedBox(height: h * 0.01),
                                    LoginField(
                                      labelText: KeyLang.EnterYourEmail.tr(),
                                      controller: emailEditingController,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        return RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(value!)
                                            ? null
                                            : "Please Enter Correct Email";
                                      },
                                    ),
                                    SizedBox(height: h * 0.01),
                                    LoginField(
                                      controller: addressEditingController,
                                      labelText: KeyLang.Address.tr(),
                                      keyboardType: TextInputType.text,
                                      validator: (val) {
                                        return val!.isEmpty || val.length < 4
                                            ? "Enter Username 4+ characters"
                                            : null;
                                      },
                                    ),
                                    SizedBox(height: h * 0.01),
                                    LoginField(
                                      controller: licenseEditingController,
                                      labelText: KeyLang.LicenseNumber.tr(),
                                      keyboardType: TextInputType.number,
                                      validator: (value) => value!.length < 5
                                          ? 'Your License Nuamber must be larger than 5 characters'
                                          : null,
                                    ),
                                    SizedBox(height: h * 0.01),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          KeyLang.AddLicensePhoto.tr(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
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
                                    SizedBox(height: h * 0.01),
                                    // ignore: sized_box_for_whitespace
                                    Container(
                                      height: 55,
                                      width: double.infinity,
                                      // ignore: deprecated_member_use
                                      child: RaisedButton(
                                        color: Colors.teal,
                                        onPressed: () {
                                          trasformToAdmin();
                                        },
                                        child: Text(
                                          KeyLang.Done.tr(),
                                          style: const TextStyle(
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
