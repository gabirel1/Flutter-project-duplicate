
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/Models/item.dart';



typedef FItem = Map<String, dynamic>;

class FirestoreService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ItemList> getItems() async {
    return _firestore.collection('Item').get().then(
        (QuerySnapshot<FItem> querySnapshot) {
          final List<Item> itemsList = <Item>[];

          for (final QueryDocumentSnapshot<FItem> item in querySnapshot.docs) {
            itemsList.add(Item.fromJson(item.data()));
          }
          return itemsList;
        }
    );
  }


}
