// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class AddEnrollment {
  CollectionReference addEnrollment =
      FirebaseFirestore.instance.collection("Enrollment Requist");

  Future<void> uploadData({
    required String? name,
    required String? age,
    required String? phone,
    required String? address,
    required String? status,
    required String? charityName
  }) async {
    return await addEnrollment.doc().set(({
          "Name": name,
          "Age": age,
          "Phone": phone,
          "Address": address,
          "Social Status ":status,
          "Charity Name" : charityName
        }));
  }


 getUserInfo(String email){
    return FirebaseFirestore.instance
        .collection("Charity")
        .where("Email", isEqualTo: email)
        .get()
        .catchError((e) {
      // ignore: avoid_print
      print(e.toString());
    });

  }

}