// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class ChAvailableItem {
  CollectionReference charityAvailableItem =
      FirebaseFirestore.instance.collection("Charity Available Item");

  Future<void> uploadData({
    required String? nameCharity,
    required String? name,
    required String? photoURL,
  }) async {
    return await charityAvailableItem.doc().set(({
          "Name Charity":nameCharity,
          "Name": name,
          "Photo URL" : photoURL
        }));
  }
}


class ChAvailableCash {
  CollectionReference chAvailableCash =
      FirebaseFirestore.instance.collection("Charity Available Cash");

  Future<void> uploadData({
    required String? nameCharity,
    required String? cash,
  }) async {
    return await chAvailableCash.doc().set(({
          "Name Charity":nameCharity,
          "Donation Amount" : cash
        }));
  }
}
