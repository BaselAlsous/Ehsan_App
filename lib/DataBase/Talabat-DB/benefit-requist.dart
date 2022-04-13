// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class AddBenefit {
  CollectionReference addBenefit =
      FirebaseFirestore.instance.collection("Benefit Requist");

  Future<void> uploadData({
    required String? name,
    required String? phone,
    required String? description,
    required String? desired,
    required String? charityName
  }) async {
    return await addBenefit.doc().set(({
          "Name": name,
          "Phone": phone,
          "Descreption For Item": description,
          "Desired Purpose": desired,
          "Charity Name" : charityName
        }));
  }


}