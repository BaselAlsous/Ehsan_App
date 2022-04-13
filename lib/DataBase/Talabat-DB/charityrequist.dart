// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class AddCharity {
  CollectionReference addCharity =
      FirebaseFirestore.instance.collection("Charity");

  Future<void> uploadData({
    required String? name,
    required String? email,
    required String? phone,
    required String? address,
    required String? license,
    required String? photoURL
  }) async {
    return await addCharity.doc().set(({
          "Name": name,
          "Email": email,
          "Phone": phone,
          "Address": address,
          "License Numbaer":license,
          "Photo URL" :photoURL
        }));
  }

}
