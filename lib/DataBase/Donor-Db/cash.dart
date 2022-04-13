// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class AddCashDonation {
  CollectionReference addCashDonation =
      FirebaseFirestore.instance.collection("Cash Donation");

  Future<void> uploadData({
    required String? name,
    required String? phone,
    required String? address,
    required String? donation
  }) async {
    return await addCashDonation.doc().set(({
          "Name": name,
          "Phone": phone,
          "Donation Amount": donation,
          "Adderss" : address
        }));
  }


}