// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/DataBase/Admin-DB/CharityNeed.dart';
import 'package:hello/DataBase/database.dart';
import 'package:hello/language/Generated/key-lang.dart';

class Something extends StatefulWidget {
final DocumentSnapshot items;

  const Something({Key? key, required this.items})
      : super(key: key);

  @override
  _SomethingState createState() => _SomethingState();
}

class _SomethingState extends State<Something> {
  String? selectedName ;
    List name = [] ;
   fetchList() async{
    dynamic result =await Database().addList();
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
    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);

    //  var nameCharety = selectedName ='';
    void uploadToFireBase({String? name, dynamic img}) {
      ChAvailableItem().uploadData(
          nameCharity: selectedName, name: name, photoURL: img);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: heightScreen * 0.17,
                  ),
                  Center(
                    child: Container(
                      height: heightScreen * 0.58,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      // padding: EdgeInsets.symmetric(
                      //    vertical: heightScreen * 0.011, horizontal: 22),
                      child: Center(
                        child: Card(
                          color:const  Color.fromRGBO(230, 225, 225, 1.0),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text("Item Type : "+
                                    widget.items["Item Type"],
                                    style: GoogleFonts.notoSerif(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text("The Adress : "+
                                    widget.items["Adderss"],
                                    style: GoogleFonts.notoSerif(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text("Discription : "+
                                    widget.items["Discription For Item"],
                                    style: GoogleFonts.notoSerif(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text("Name : "+
                                    widget.items["Name"],
                                    style: GoogleFonts.notoSerif(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text("The Phone : "+
                                    widget.items["Phone"],
                                    style: GoogleFonts.notoSerif(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                               SizedBox(
                                height: heightScreen * 0.05,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Enter Charity Name ",
                                  style: GoogleFonts.notoSerif(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              DropdownButton(
                                dropdownColor: Colors.white,
                                items: name
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
                                style: const TextStyle(
                                color: Color.fromRGBO(
                                136, 152, 170, 1.0),
                                ),
                                ),
                                ),
                              
                              // ignore: avoid_unnecessary_containers
                             
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                // ignore: avoid_unnecessary_containers
                                child: Column(
                                  children: [
                                    // ignore: avoid_unnecessary_containers
                                    Container(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        onPressed: () {
                                          uploadToFireBase(
                                              name: widget.items["Item Type"],
                                              img:  widget.items["Photo Url"]);
                                           widget.items.reference
                                              .delete()
                                              .whenComplete(() => Navigator.pop(context));
                                        },
                                        child: const Text(
                                          "accept",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    // ignore: avoid_unnecessary_containers
                                    Container(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        onPressed: () {
                                          // uploadToFireBase(
                                          //     name: widget.items["Item Type"],
                                          //     img:  widget.items["Photo Url"]);
                                           widget.items.reference
                                              .delete()
                                              .whenComplete(() => Navigator.pop(context));
                                        },
                                        child: const Text(
                                          "delete",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
