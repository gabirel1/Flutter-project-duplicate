import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    debugPrint('checkUserAlreadyExists: "$email"');
    final QuerySnapshot<FItem> result = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    final List<QueryDocumentSnapshot<FItem>> documents = result.docs;
    debugPrint(documents.toString());
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
        debugPrint(e.toString());
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
    if (kDebugMode) {
      debugPrint('getUserInfos: "$uuid"');
    }
    if (uuid.isEmpty) {
      return UserInfos(
        uuid: ' ',
        email: '',
        profilePicture: '',
        isSeller: false,
        formatedEmail: '',
      );
    }
    return _firestore
        .collection('users')
        .doc(uuid)
        .get()
        .then((DocumentSnapshot<FItem> documentSnapshot) {
      if (!documentSnapshot.exists) {
        debugPrint('Document does not exist on the database');
        return UserInfos(
          uuid: ' ',
          email: '',
          profilePicture: '',
          isSeller: false,
          formatedEmail: '',
        );
      }
      final dynamic tmp = documentSnapshot.data()!;
      // add value 'formatedEmail' to the object
      debugPrint(tmp.toString());
      tmp.addAll(<String, dynamic>{
        'formatedEmail': '',
      });
      final UserInfos temp = UserInfos.fromJson(tmp);
      final String email = temp.email;
      final int len = email.indexOf('@');
      String username = email.substring(0, (len > -1 ? len : email.length));
      username = username.substring(
        0,
        (username.length > 10) ? 10 : username.length,
      );
      temp.formatedEmail = username;
      return temp;
    });
  }

  String getCurrentUserUUID() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      return user.uid;
    }
    return ' ';
  }
}
