// ignore_for_file: file_names, implementation_imports

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart'as auth;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/Admin/admain-screen.dart';
import 'package:hello/DataBase/Talabat-DB/enrollment_requist.dart';
import 'package:hello/Views/Charity/Login/Helper-Login/Helpers-Function.dart';
import 'package:hello/Views/Charity/Login/Services/Authentication-Firebase.dart';
import 'package:hello/Views/Talabat/Talpat-Screen/charity-requist-talabat.dart';
import 'package:hello/Widget/Login-Filed.dart';
import 'package:hello/language/Generated/key-lang.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool forgetPass = false;

  TextEditingController emailEditingController = TextEditingController()
    ..text = '';
  TextEditingController passwordEditingController = TextEditingController()
    ..text = '';

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final authService = Provider.of<AuthService>(context);

    void signin() async{
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        try {
            await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
             email: emailEditingController.text,
             password: passwordEditingController.text).then((value) async {
            // ignore: unnecessary_null_comparison
            if (value != null) {
              String admin = "admin@gmail.com";
              if (emailEditingController.text == admin) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const AdmainHome()));
              }else{
              QuerySnapshot userInfoSnapshot = await AddEnrollment()
                  .getUserInfo(emailEditingController.text);
              HelpersFunction.saveUserLoggedInSharedPreference(true);
              HelpersFunction.saveUserIdInSharedPreference(
                  userInfoSnapshot.docs[0]['Name']);
              Navigator.pushNamed(context, '/Charity');
              }
            }
          });
        }on auth.FirebaseAuthException  catch (e) {
            if (e.code == 'user-not-found') {
               showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title:  Text(KeyLang.Error.tr(),
                    style:const  TextStyle(color: Colors.black87, fontSize: 17),
                  ),
                  content:  Text(
                   KeyLang.Nouserfoundforthatemail.tr(),
                    style:const  TextStyle(color: Colors.black87, fontSize: 17),
                  ),
                  actions: [
                    Center(
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/SignIn');
                          },
                          child:  Text(
                            KeyLang.Back.tr(),
                            style:const
                                TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }else if (e.code == 'wrong-password') {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title:  Text(KeyLang.Error.tr(),
                    style:const  TextStyle(color: Colors.black87, fontSize: 17),
                  ),
                  content:  Text(
                    KeyLang.wrongpassword.tr(),
                    style:const TextStyle(color: Colors.black87, fontSize: 17),
                  ),
                  actions: [
                    Center(
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/SignIn');
                          },
                          child:  Text(
                             KeyLang.Back.tr(),
                            style:const
                                TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

         }
      }
    }

    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Scaffold(
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
                        height: height * 0.5,
                        decoration: const BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(150),
                            bottomRight: Radius.circular(150),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: height * 0.08),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                     Navigator.pop(context);
                                     Navigator.pushNamed(context, '/MyHomePage');
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.15),
                            Text(KeyLang.WelcomeToEhsanApp.tr(),
                                style: GoogleFonts.playfairDisplay(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  fontStyle: FontStyle.italic,
                                )),
                            SizedBox(
                              height: height * 0.221,
                            ),
                            Form(
                              key: _formKey,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: height * 0.03),
                                     LoginField(
                                      labelText: KeyLang.EnterYourEmail.tr(),
                                      keyboardType: TextInputType.emailAddress,
                                      controller: emailEditingController,
                                      validator: (value) {
                                        return RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(value!)
                                            ? null
                                            : "Please Enter Correct Email";
                                      },
                                    ),
                                    SizedBox(height: height * 0.01),
                                    LoginField(
                                        labelText: KeyLang.EnterYourPassword.tr(),
                                        keyboardType: TextInputType.text,
                                        obscureText: true,
                                        controller: passwordEditingController,
                                        validator: (value) => value!.length < 8
                                            ? 'Your password must be larger than 8 characters'
                                            : null),
                                    SizedBox(height: height * 0.02),
                                    // ignore: sized_box_for_whitespace
                                    Container(
                                      height: height * 0.08,
                                      width: double.infinity,
                                      // ignore: deprecated_member_use
                                      child: RaisedButton(
                                        onPressed: signin,
                                        child: Text(
                                          KeyLang.SignIn.tr(),
                                          style: GoogleFonts.podkova(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        color: Colors.teal,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const talbElthaq())),
                                      child: Text(
                                        KeyLang.Donothaveanaccount.tr(),
                                        style: GoogleFonts.mPlus1(
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontStyle: FontStyle.italic,
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
