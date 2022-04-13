// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class AddDonateSomething {
  CollectionReference addDonateSomething =
      FirebaseFirestore.instance.collection("Donate Something");

  Future<void> uploadData({
    required String? name,
    required String? phone,
    required String? address,
    required String? discr,
    required String? photo,
    required String? item


  }) async {
    return await addDonateSomething.doc().set(({
          "Name": name,
          "Phone": phone,
          "Discription For Item": discr,
          "Adderss" : address,
          "Item Type" : item,
          "Photo Url" : photo,


        }));
  }


}