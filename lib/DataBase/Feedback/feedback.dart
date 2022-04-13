// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class AddFeedback {
  CollectionReference addFeedback =
      FirebaseFirestore.instance.collection("Feedback");

  Future<void> uploadData({
    required String? name,
    required String? feedback,
  }) async {
    return await addFeedback.doc().set(({
          "Name": name,
          "Feedback": feedback,
        }));
  }
}
