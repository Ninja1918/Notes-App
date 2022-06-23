import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class DataBaseServices {
  static Future<void> addData(
      String title, String detail, String collection, String date) async {
    firebaseFirestore
        .collection(collection)
        .add({"title": title, "detail": detail, 'date' : date})
        .whenComplete(() => print('Add Success'))
        .catchError((e) {
          print(e.toString());
        });
  }
}

Future<void> delete(String id, String collection) async {
  await firebaseFirestore.collection(collection).doc(id).delete();
}

Future<void> updateData(
    String id, String title, String detail, String collection) async {
  await firebaseFirestore
      .collection(collection)
      .doc(id)
      .update({'title': title, 'detail': detail});
}
