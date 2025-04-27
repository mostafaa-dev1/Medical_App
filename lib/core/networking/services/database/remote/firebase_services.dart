import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServices {
  // Step 1: Create a private static instance
  static final FirebaseServices _instance = FirebaseServices._internal();

  // Step 2: Provide a factory constructor to return the same instance
  factory FirebaseServices() {
    return _instance;
  }

  // Step 3: Private named constructor (prevents multiple instances)
  FirebaseServices._internal();

  // Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Firebase Storage instance
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Firestore CRUD operations
  Future<void> addData(
      Map<String, dynamic> data, String collection, String id) async {
    await _db.collection(collection).doc(id).set(data);
  }

  Future<void> updateData(
      Map<String, dynamic> data, String collection, String id) async {
    await _db.collection(collection).doc(id).update(data);
  }

  Future<void> deleteData(String collection, String id) async {
    await _db.collection(collection).doc(id).delete();
  }

  Future<List<Map<String, dynamic>>> readData(String collection) async {
    var response = await _db.collection(collection).get();
    return response.docs.map((e) => e.data()).toList();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> readDataById(
      String collection, String id) async {
    return await _db.collection(collection).doc(id).get();
  }

  // Sub-collection operations
  Future<void> addDataByCollection(Map<String, dynamic> data,
      String collection1, String id, String collection2, String id2) async {
    await _db
        .collection(collection1)
        .doc(id)
        .collection(collection2)
        .doc(id2)
        .set(data);
  }

  Future<List<Map<String, dynamic>>> readDataByCollection(
      String collection, String id, String subCollection) async {
    var response = await _db
        .collection(collection)
        .doc(id)
        .collection(subCollection)
        .get();
    return response.docs.map((e) => e.data()).toList();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?>
      readDataByCollectionandSubCollection(String collection, String id,
          String subCollection, String id2) async {
    return await _db
        .collection(collection)
        .doc(id)
        .collection(subCollection)
        .doc(id2)
        .get();
  }

  // Image Upload to Firebase Storage
  Future<Either<String, String>> uploadImage(
      {required File image, required String filename}) async {
    try {
      Reference ref =
          _storage.ref().child('$filename/${image.path.split('/').last}');
      await ref.putFile(image);
      String url = await ref.getDownloadURL();
      return Right(url);
    } catch (e) {
      return Left('Image could not be uploaded');
    }
  }
}
