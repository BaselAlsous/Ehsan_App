// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardHorizontal extends StatelessWidget {
  // ignore: use_key_in_widget_constructors


  final String img;
  final Function()? tap;
  final String title;
  final String cta ;
 

  // ignore: use_key_in_widget_constructors
  const CardHorizontal(
      {
        required this.title ,
        this.img = "https://via.placeholder.com/200",
        required this.tap,
        this.cta = "View" ,
      });



  @override
  Widget build(BuildContext context) {
    var h = (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top );
     var w = (MediaQuery.of(context).size.width);
    // ignore: sized_box_for_whitespace
    return Container(
      height: h * 0.18,
      child: GestureDetector(
        onTap: tap,
        child: Card(
          color: Colors.white,
          elevation: 5,
          shape:const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        bottomLeft: Radius.circular(6.0)),
                    image: DecorationImage(
                      image: AssetImage(img),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding:  EdgeInsets.all(w * 0.02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.robotoSlab(
                          color: const Color.fromRGBO(46, 47, 71, 1.0),
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Container(
                        margin:const EdgeInsets.only(top: 10 , right: 30),
                        child: Text(
                          cta,
                          style: GoogleFonts.playfairDisplay(
                            color: const Color.fromRGBO(52, 66, 177, 1.0),
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
