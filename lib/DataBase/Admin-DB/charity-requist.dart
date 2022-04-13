// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class AddCharityRequist {
  CollectionReference addCharityRequist =
      FirebaseFirestore.instance.collection("Charity Requist");

  Future<void> uploadData({
    required String? name,
    required String? phone,
    required String? email,
    required String? address,
    required String? license,
    required String? photoURL,
  }) async {
    return await addCharityRequist.doc().set(({
          "Name": name,
          "Email": email,
          "License Numbaer":license,
          "Phone Number" : phone,
          "Address" :address,
          "Photo URL" : photoURL
        }));
  }
}
