import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {
  // Categories
  // read categories from database
  Stream<QuerySnapshot> readCategories() {
    return FirebaseFirestore.instance.collection("shop_categories").snapshots();
  }

  // Create new category
  Future createCategories({required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance.collection("shop_categories").add(data);
  }

  // Update category
  Future updateCategories(
      {required String docId, required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance
        .collection("shop_categories")
        .doc(docId)
        .update(data);
  }

  // Delete category
  Future deleteCategories({required String docId}) async {
    await FirebaseFirestore.instance
        .collection("shop_categories")
        .doc(docId)
        .delete();
  }
}
