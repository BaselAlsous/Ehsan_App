import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  addList() async {
    List charityNmae = [];
    List charity = [];
    await FirebaseFirestore.instance.collection("Charity").get().then(
          // ignore: avoid_function_literals_in_foreach_calls
          (value) => value.docs.forEach(
            (element) {
              charityNmae.add(element.data());
            },
          ),
        );

    for (int i = 0; i <= charityNmae.length - 1; i++) {
      charity.add(charityNmae[i]["Name"]);
    }
    return charity;
  }

  addeList() async {
    List charityNmae = [];
    await FirebaseFirestore.instance.collection("Charity").get().then(
          // ignore: avoid_function_literals_in_foreach_calls
          (value) => value.docs.forEach(
            (element) {
              charityNmae.add(element.data());
            },
          ),
        );
    return charityNmae;
  }

  serchNumber(String searchField) async {
    await FirebaseFirestore.instance
        .collection('Family Number')
        .where('Needy Family Number', isEqualTo: searchField)
        .get();
  }
}
