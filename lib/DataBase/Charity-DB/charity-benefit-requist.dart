// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class AddCharityBenefit {
  CollectionReference addCharityBenefit =
      FirebaseFirestore.instance.collection("Charity Benefit Requist");

  Future<void> uploadData({
    required String? name,
    required String? desired,
    required String? descr,
  }) async {
    return await addCharityBenefit.doc().set(({
          "Charity Name" :name ,
          "Desired Purpose": desired,
          "Descreption For Item": descr,
        }));
  }
}
