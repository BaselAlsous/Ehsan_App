// ignore_for_file: file_names, implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello/DataBase/Talabat-DB/enrollment_requist.dart';
import 'package:hello/DataBase/database.dart';
import 'package:hello/Widget/Login-Filed.dart';
import 'package:hello/language/Generated/key-lang.dart';

// ignore: camel_case_types
class talbmohtaj extends StatefulWidget {
  const talbmohtaj({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<talbmohtaj> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? selectedName;
  List charityNmae = [];
  List name = [];
  TextEditingController nameEditingController = TextEditingController()
    ..text = '';
  TextEditingController ageEditingController = TextEditingController()
    ..text = '';
  TextEditingController phoneEditingController = TextEditingController()
    ..text = '';
  TextEditingController statusEditingController = TextEditingController()
    ..text = '';
  TextEditingController addressEditingController = TextEditingController()
    ..text = '';

  void uploadToCharityBage() {
    if (nameEditingController.text.isEmpty ||
        addressEditingController.text.isEmpty ||
        phoneEditingController.text.isEmpty ||
        statusEditingController.text.isEmpty ||
        addressEditingController.text.isEmpty) {
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
      AddEnrollment().uploadData(
          name: nameEditingController.text,
          age: ageEditingController.text,
          phone: phoneEditingController.text,
          address: addressEditingController.text,
          status: statusEditingController.text,
          charityName: selectedName);
      deleteField();
      Navigator.pop(context);
    }
  }

  void deleteField() {
    nameEditingController.text = "";
    phoneEditingController.text = "";
    addressEditingController.text = "";
    statusEditingController.text = "";
    ageEditingController.text = "";
  }

  fetchList() async {
    dynamic result = await Database().addList();
    if (result == null) {
      // ignore: avoid_print
      print('Unable to retrieve');
    } else {
      setState(() {
        name = result;
      });
    }
  }

  @override
  void initState() {
    fetchList();
    super.initState();
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
                              KeyLang.NeedyEnrollmentRequist.tr(),
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
                                      controller: nameEditingController,
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
                                      controller: ageEditingController,
                                      labelText: KeyLang.YourAge.tr(),
                                      keyboardType: TextInputType.number,
                                      validator: (value) => value!.length < 8
                                          ? 'Your password must be larger than 8 characters'
                                          : null,
                                    ),
                                    SizedBox(height: h * 0.01),
                                    LoginField(
                                      controller: statusEditingController,
                                      labelText: KeyLang.SocialStatus.tr(),
                                      keyboardType: TextInputType.text,
                                      validator: (value) => value!.length < 8
                                          ? 'Your password must be larger than 8 characters'
                                          : null,
                                    ),
                                    SizedBox(height: h * 0.01),
                                    LoginField(
                                      controller: addressEditingController,
                                      labelText: KeyLang.Address.tr(),
                                      keyboardType: TextInputType.text,
                                      validator: (value) => value!.length < 8
                                          ? 'Your password must be larger than 8 characters'
                                          : null,
                                    ),
                                    SizedBox(height: h * 0.01),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.teal,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(25),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.add_box,
                                                color: Colors.teal,
                                              ),
                                            ),
                                            DropdownButton(
                                              dropdownColor: Colors.white,
                                              items: name
                                                  .map(
                                                    (value) => DropdownMenuItem(
                                                      child: Text(
                                                        value,
                                                        style: const TextStyle(
                                                          color: Color.fromRGBO(
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
                                              onChanged: (selectedAccountType) {
                                                setState(
                                                  () {
                                                    selectedName =
                                                        selectedAccountType
                                                            .toString();
                                                  },
                                                );
                                              },
                                              value: selectedName,
                                              isExpanded: false,
                                              hint:  Text(
                                                KeyLang.CharityName.tr(),
                                                style:const TextStyle(
                                                  color: Color.fromRGBO(
                                                      136, 152, 170, 1.0),
                                                ),
                                              ),
                                            ),
                                          ],
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
                                        onPressed: () =>
                                            {uploadToCharityBage()},
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
