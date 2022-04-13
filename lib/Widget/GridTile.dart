// ignore_for_file: file_names, prefer_const_constructors_in_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class BuildGrid extends StatelessWidget {
  final String id;
  final String desc;
  // ignore: prefer_typing_uninitialized_variables
  var img;
  final Function()? tap;
  final String title;

  BuildGrid(
      {Key? key,
      this.id = " ",
      this.title = "",
      this.desc = ' ',
      this.img = "asset/image/Requst/person.png",
      this.tap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.blueAccent.shade100,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: InkWell(
        onTap: tap,
        child: GridTile(
          footer: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  child: Center(
                    child: Text(title,
                        style: GoogleFonts.notoSerif(
                            color: Colors.white,
                            fontSize: 17,
                            fontStyle: FontStyle.italic)),
                  ))
            ],
          ),
          child: CachedNetworkImage(
              imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill),
                    ),
                  ),
              placeholder: (context, url) => SizedBox(
                    child: const CircularProgressIndicator(
                      strokeWidth: 1.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFFff6768),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * .4,
                  ),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error, size: 150),
              width: MediaQuery.of(context).size.width * .4,
              fit: BoxFit.cover,
              imageUrl: img.toString()),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BuildEnrollmentGrid extends StatelessWidget {
  final String id;
  final String desc;
  // ignore: prefer_typing_uninitialized_variables
  final String img;
  final Function()? tap;
  final String title;

  BuildEnrollmentGrid(
      {Key? key,
      this.id = " ",
      this.title = "",
      this.desc = ' ',
      this.img = "asset/image/Requst/person.png",
      this.tap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.blueAccent.shade100,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: InkWell(
        onTap: tap,
        child: GridTile(
            footer: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Center(
                      child: Text(title,
                          style: GoogleFonts.notoSerif(
                              color: Colors.white,
                              fontSize: 17,
                              fontStyle: FontStyle.italic)),
                    ))
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(img),
              )),
            )),
      ),
    );
  }
}
