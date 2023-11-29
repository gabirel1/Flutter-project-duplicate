import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Models/item.dart';
import 'package:my_app/Models/user_infos.dart';

typedef FItem = Map<String, dynamic>;

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ItemList> getItems() async {
    return _firestore
        .collection('Item')
        .get()
        .then((QuerySnapshot<FItem> querySnapshot) {
      final List<Item> itemsList = <Item>[];

      for (final QueryDocumentSnapshot<FItem> item in querySnapshot.docs) {
        itemsList.add(Item.fromJson(item.data()));
      }
      return itemsList;
    });
  }

  Future<bool> checkUserAlreadyExists(String email) async {
    final QuerySnapshot<FItem> result = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    final List<QueryDocumentSnapshot<FItem>> documents = result.docs;
    if (documents.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkUserAlreadyExistsV2(String uuid) async {
    final QuerySnapshot<FItem> result = await _firestore
        .collection('users')
        .where('uuid', isEqualTo: uuid)
        .limit(1)
        .get();
    final List<QueryDocumentSnapshot<FItem>> documents = result.docs;
    if (documents.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addUser(
    String uuid,
    String email,
    String? profilePicture, {
    bool isSeller = false,
  }) async {
    try {
      await _firestore.collection('users').doc(uuid).set(<String, Object>{
        'uuid': uuid,
        'email': email,
        'profilePicture': profilePicture ?? '',
        'isSeller': isSeller,
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      AlertDialog(
        title: const Text('Error'),
        content: Text(e.toString()),
        actions: const <Widget>[],
      );
      return false;
    }
  }

  Future<UserInfos> getUserInfos(String uuid) async {
    return _firestore
        .collection('user')
        .doc(uuid)
        .get()
        .then((DocumentSnapshot<FItem> documentSnapshot) {
      return UserInfos.fromJson(documentSnapshot.data()!);
    });
  }
}
