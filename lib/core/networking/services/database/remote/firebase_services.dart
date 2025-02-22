import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServices {
  static var db = FirebaseFirestore.instance;

  static Future<void> addData(
      Map<String, dynamic> data, String collection, String id) async {
    await db.collection(collection).doc(id).set(data);
  }

  static Future<void> addDataByCollection(Map<String, dynamic> data,
      String collection1, String id, String collection2, String id2) async {
    await db
        .collection(collection1)
        .doc(id)
        .collection(collection2)
        .doc(id2)
        .set(data);
  }

  static Future<void> updateData(
      Map<String, dynamic> data, String collection, String id) async {
    await db.collection(collection).doc(id).update(data);
  }

  static Future<void> updateDatabyCollectionandSubCollection(
    String collection,
    String id,
    String subCollection,
    String id2,
    Map<String, dynamic> data,
  ) async {
    var response = await db
        .collection(collection)
        .doc(id)
        .collection(subCollection)
        .doc(id2)
        .update(data);

    return response;
  }

  static Future<void> deleteData(String collection, String id) async {
    await db.collection(collection).doc(id).delete();
  }

  static Future<List<Map<String, dynamic>>> readData(String collection) async {
    var response = await db.collection(collection).get();
    return response.docs.map((e) => e.data()).toList();
  }

  static Future<List<Map<String, dynamic>>> readDataByCollection(
      String collection, String id, String subCollection) async {
    var response =
        await db.collection(collection).doc(id).collection(subCollection).get();
    return response.docs.map((e) => e.data()).toList();
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>?>
      readDataByCollectionandSubCollection(String collection, String id,
          String subCollection, String id2) async {
    var response = await db
        .collection(collection)
        .doc(id)
        .collection(subCollection)
        .doc(id2)
        .get();
    return response;
  }

  static Future<void> setDataByCollectionandSubCollection(
      String collection,
      String id,
      String subCollection,
      String id2,
      Map<String, dynamic> data) async {
    await db
        .collection(collection)
        .doc(id)
        .collection(subCollection)
        .doc(id2)
        .set(
          data,
        );
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> readDataById(
      String collection, String id) async {
    var response = await db.collection(collection).doc(id).get();
    return response;
  }

  Future<Either<String, String>> uploadImage({required File image}) async {
    try {
      final storage = FirebaseStorage.instance.ref();

      Reference ref =
          storage.child('ProfileImages/${image.path.split('/').last}');
      await ref.putFile(image);
      String url = await ref.getDownloadURL();
      return Right(url);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
