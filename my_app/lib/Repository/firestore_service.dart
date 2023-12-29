import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/Models/item.dart';
import 'package:my_app/Models/my_orders.dart';
import 'package:my_app/Models/order_item.dart';
import 'package:my_app/Models/user_infos.dart';
import 'package:my_app/Tools/utils.dart';
import 'package:uuid/uuid.dart';
// import 'package:path/path.dart';

/// FItem is a Map<String, dynamic>
typedef FItem = Map<String, dynamic>;

/// Class used to interact with the firestore
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// return a list of items
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

  /// return an item
  Future<Item> getItem(String itemId) async {
    return _firestore
        .collection('Item')
        .doc(itemId)
        .get()
        .then((DocumentSnapshot<FItem> documentSnapshot) {
      if (!documentSnapshot.exists) {
        return Item(
          id: '',
          description: '',
          title: '',
          seller: '',
          sellerUUID: '',
          images: <String>[],
          price: 0,
        );
      }
      final dynamic tmp = documentSnapshot.data()!;
      return Item.fromJson(tmp);
    });
  }

  /// return true if the user already exists
  /// return false if the user does not exists
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

  /// return true if the user already exists
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

  /// a function to add a user to the firestore
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

  /// a function to retrieve the user infos from the firestore
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

  /// a function to retrieve the uuid of the current user
  String getCurrentUserUUID() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      return user.uid;
    }
    return ' ';
  }

  /// a function to retrieve the email of the current user
  String getCurrentUserEmail() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      return user.email ?? '';
    }
    return ' ';
  }

  /// a function to handle the login with google on web
  Future<(bool, String)> handleGoogleLoginWeb() async {
    final GoogleAuthProvider googleProvider = GoogleAuthProvider();

    debugPrint(googleProvider.toString());
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
    if (await FirestoreService()
            .checkUserAlreadyExistsV2(userCredential.user?.uid ?? '') ==
        false) {
      // remove the user from firebase
      await userCredential.user?.delete();
      return (false, '');
    }
    debugPrint(userCredential.toString());
    return (true, userCredential.user?.uid ?? '');
  }

  /// a function to handle the login with google
  Future<(bool, String)> handleGoogleLogin() async {
    if (MyPlatform.isWeb()) {
      return handleGoogleLoginWeb();
    }
    final GoogleSignInAccount? user = await GoogleSignIn(
      clientId:
          '495774674643-o54oh2p0eqdf4q8l0sf6rsglppl87u88.apps.googleusercontent.com',
    ).signIn();
    final GoogleSignInAuthentication? auth = await user?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: auth?.accessToken,
      idToken: auth?.idToken,
    );

    final bool userExists =
        await FirestoreService().checkUserAlreadyExists(user?.email ?? '');
    debugPrint(userExists.toString());
    if (userExists == false) {
      return (false, '');
    }
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    debugPrint(userCredential.toString());
    debugPrint(userCredential.user?.uid);
    return (true, userCredential.user?.uid ?? '');
  }

  /// a function to register a user in firebase
  Future<bool> _registerUserInFirebase(
    String email,
    String uuid,
    String profilePicture,
    bool isSeller,
  ) {
    return addUser(
      uuid,
      email,
      profilePicture,
      isSeller: isSeller,
    );
  }

  /// a function to handle the register with google on web
  Future<bool> handleGoogleRegisterWeb({bool wantToBeSeller = false}) async {
    final GoogleAuthProvider googleProvider = GoogleAuthProvider();

    debugPrint(googleProvider.toString());
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithPopup(googleProvider);

    if (await FirestoreService()
                .checkUserAlreadyExistsV2(userCredential.user?.uid ?? '') ==
            true ||
        userCredential.user == null ||
        userCredential.user?.email == null) {
      return false;
    }
    debugPrint(userCredential.toString());
    final bool res = await _registerUserInFirebase(
      userCredential.user!.email ?? '',
      userCredential.user!.uid,
      userCredential.user!.photoURL ?? '',
      wantToBeSeller,
    );
    return res;
  }

  /// a function to handle the register with google
  Future<bool> handleGoogleRegister({bool wantToBeSeller = false}) async {
    if (MyPlatform.isWeb()) {
      return handleGoogleRegisterWeb();
    }
    final GoogleSignInAccount? user = await GoogleSignIn(
      clientId:
          '495774674643-o54oh2p0eqdf4q8l0sf6rsglppl87u88.apps.googleusercontent.com',
    ).signIn();
    final GoogleSignInAuthentication? auth = await user?.authentication;
    debugPrint(auth?.accessToken);
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: auth?.accessToken,
      idToken: auth?.idToken,
    );
    // check if user already exists in firebas edatabase if not create it
    final bool userExists =
        await FirestoreService().checkUserAlreadyExists(user?.email ?? '');
    if (userExists == true) {
      return false;
    }
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    debugPrint(userCredential.toString());
    debugPrint(userCredential.user?.uid);
    final bool res = await _registerUserInFirebase(
      userCredential.user!.email ?? '',
      userCredential.user!.uid,
      userCredential.user!.photoURL ?? '',
      wantToBeSeller,
    );
    return res;
  }

  /// a function to handle the login with email and password
  Future<(bool, String, String)> handleLogin(
    String email,
    String password,
  ) async {
    final bool isValid = MyUtils.checkFormValidityLogin(email, password);
    if (isValid == false) return (false, 'Please fill all fields.', ' ');

    if (await FirestoreService().checkUserAlreadyExists(email) == false) {
      debugPrint('No user found for that email.');
      return (false, 'Wrong credentials.', ' ');
    }
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      debugPrint('credentials $credential.toString()');
      return (true, 'Logged in successfully.', credential.user?.uid ?? ' ');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        return (false, 'Wrong credentials.', ' ');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        return (false, 'Wrong credentials.', ' ');
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        return (false, 'Wrong credentials.', ' ');
      }
      debugPrint(e.code);
      return (false, e.code, ' ');
    } catch (e) {
      debugPrint(e.toString());
      return (false, 'An error occured, please try again later.', ' ');
    }
  }

  /// a function to handle the register with email and password
  Future<(bool, String)> handleRegister(
    String email,
    String password,
    String passwordConfirm, {
    required bool wantToBeSeller,
  }) async {
    final (bool, String) res =
        MyUtils.checkFormValidityV2(email, password, passwordConfirm);
    if (res.$1 == false) return (false, res.$2);

    try {
      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint(credential.toString());
      final bool res = await _registerUserInFirebase(
        email,
        credential.user!.uid,
        '',
        wantToBeSeller,
      );
      return (res, 'Registered successfully.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        return (false, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        return (false, 'The account already exists for that email.');
      }
      return (false, e.code);
    } catch (e) {
      debugPrint(e.toString());
      return (false, 'An error occured, please try again later.');
    }
  }

  /// a function to add an image to the storage
  Future<(bool, String)> addPictureToStorage(XFile img) async {
    final File imageFile = File(img.path);
    // final String fileName = basename(imageFile.path);
    final String productPath = 'profilePictures/${getCurrentUserUUID()}';

    final Reference ref = _storage.ref().child(productPath);
    final UploadTask uploadTask = ref.putFile(imageFile);
    try {
      String imgUrl = '';
      await uploadTask.whenComplete(() async {
        final String url = await ref.getDownloadURL();
        imgUrl = url;
      });
      return (true, imgUrl);
    } catch (e) {
      debugPrint(e.toString());
      return (false, '');
    }
  }

  /// a function to add an image to the storage
  Future<(bool, String)> addItemImageToStorage(XFile img) async {
    final File imageFile = File(img.path);
    // final String fileName = basename(imageFile.path);
    final String productPath = 'itemsPictures/${const Uuid().v4()}';

    final Reference ref = _storage.ref().child(productPath);
    final UploadTask uploadTask = ref.putFile(imageFile);
    try {
      String imgUrl = '';
      await uploadTask.whenComplete(() async {
        final String url = await ref.getDownloadURL();
        imgUrl = url;
      });
      return (true, imgUrl);
    } catch (e) {
      debugPrint(e.toString());
      return (false, '');
    }
  }


  /// a function to change the user profile picture
  Future<bool> changeUserProfilePicture(
    String uuid,
    String newPictureURL,
  ) async {
    try {
      await _firestore.collection('users').doc(uuid).update(<String, Object>{
        'profilePicture': newPictureURL,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  /// Function to get the orders of an user
  Future<OrderList> getOrders(String userID) async {
    return _firestore
        .collection('Orders')
        .where('userID', isEqualTo: userID)
        .get()
        .then((QuerySnapshot<FItem> querySnapshot) async {
      final List<MyOrder> ordersList = <MyOrder>[];

      for (final QueryDocumentSnapshot<FItem> order in querySnapshot.docs) {
        final MyOrder tmp = MyOrder(
          userID: '',
          items: <OrderItem>[],
          totalPrice: 0,
          orderedAt: DateTime.now().toString(),
        )
          ..userID = order.data()['userID'] as String
          ..totalPrice = order.data()['totalPrice'] as double
          ..orderedAt = DateTime.fromMillisecondsSinceEpoch(
            (order.data()['orderedAt'] as Timestamp).seconds * 1000,
          ).toString().substring(0, 10);

        for (final dynamic item in order.data()['items']) {
          final dynamic itemDOC = item['item'];
          final String docPath = itemDOC.path;
          final Item finalItem = await _firestore.doc(docPath).get().then(
            (DocumentSnapshot<FItem> documentSnapshot) {
              final dynamic tmp = documentSnapshot.data()!;
              return Item.fromJson(tmp);
            },
          );
          tmp.items.add(
            OrderItem(
              item: finalItem,
              quantity: item['howMany'] as int,
            ),
          );
        }
        ordersList.add(tmp);
      }
      return ordersList;
    });
  }

  /// Function to retrieve the selling items of a seller
  Future<ItemList> getSellingItems(String sellerUUID) async {
    return _firestore
        .collection('Item')
        .where('sellerUUID', isEqualTo: sellerUUID)
        .get()
        .then((QuerySnapshot<FItem> querySnapshot) {
      final List<Item> itemsList = <Item>[];

      for (final QueryDocumentSnapshot<FItem> item in querySnapshot.docs) {
        itemsList.add(Item.fromJson(item.data()));
      }
      return itemsList;
    });
  }

  /// Function to delete an item from the store (needs to be done by the item's seller)
  /// @param [itemID] is the id of the item to delete
  Future<bool> deleteItem(String itemID) async {
    try {
      // check if the item's seller is the current user
      final Item item = await _firestore
          .collection('Item')
          .doc(itemID)
          .get()
          .then((DocumentSnapshot<FItem> documentSnapshot) {
        final dynamic tmp = documentSnapshot.data()!;
        return Item.fromJson(tmp);
      });

      if (item.sellerUUID != getCurrentUserUUID()) {
        debugPrint('You are not the seller of this item');
        return false;
      }
      await _firestore.collection('Item').doc(itemID).delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  /// Function to add an item to the store
  /// `images` is a list of images url
  /// (You should use the function addPictureToStorage prior to this one to get the url of the images)
  Future<bool> sellerAddItem(
    String title,
    String description,
    double price,
    List<String> images,
  ) async {
    try {
      final String email = getCurrentUserEmail();
      final String uuid = getCurrentUserUUID();

      if (email.isEmpty || uuid.isEmpty) {
        debugPrint('You are not logged in');
        return false;
      }
      await _firestore.collection('Item').add(<String, Object>{
        'title': title,
        'description': description,
        'price': price,
        'images': images,
        'seller': email,
        'sellerUUID': uuid,
      }).then((DocumentReference<Map<String, dynamic>> docRef) => <Future<void>>{
        _firestore.collection('Item').doc(docRef.id).update(<Object, Object?>{'id': docRef.id}),
      },);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  /// Function to create an order
  /// `items` is a list of items
  /// `totalPrice` is the total price of the order
  /// `userID` is the id of the user who ordered
  /// `howMany` is a list of int that contains the quantity of each item
  Future<bool> createOrder(
    List<OrderItem> items,
    double totalPrice,
    String userID,
    //List<int> howMany,
  ) async {
    try {
      final List<Map<String, Object>> itemsList = <Map<String, Object>>[];
      for (int i = 0; i < items.length; i++) {
        final Item item = items[i].item;
        final String itemID = item.id;
        final DocumentReference<Map<String, dynamic>> itemRef =
            _firestore.collection('Item').doc(itemID);
        itemsList.add(<String, Object>{
          'item': itemRef,
          'howMany': items[i].quantity,
        });
      }
      await _firestore.collection('Orders').add(<String, Object>{
        'userID': userID,
        'items': itemsList,
        'totalPrice': totalPrice,
        'orderedAt': DateTime.now(),
      });

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
