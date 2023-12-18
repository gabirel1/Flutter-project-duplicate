import 'package:flutter/material.dart';
import 'package:my_app/Models/item.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/Actions/qr_code_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

/// The qr_code view model
class QrCodeViewModel {
  /// The qr_code view model
  QrCodeViewModel({
    required this.itemId,
    required this.item,
    required this.setItemId,
    required this.loadItem,
  });

  /// The qr_code view model factory
  factory QrCodeViewModel.factory(
    Store<AppState> store,
    FirestoreService firestore,
  ) {
    return QrCodeViewModel(
      itemId: store.state.qrCode.itemId,
      item: store.state.qrCode.item,
      setItemId: (String itemId) {
        store.dispatch(QrCodeItemIdAction(itemId: itemId));
      },
      loadItem: () async {
        debugPrint('store item id : ${store.state.qrCode.itemId}');
        final Item response =
            await firestore.getItem(store.state.qrCode.itemId);
        debugPrint('response item id : ${response.id}');
        store.dispatch(QrCodeLoadItemAction(item: response));
        return response;
      },
    );
  }

  /// The item Id
  final String itemId;

  /// The item
  Item item;

  /// The set item Id
  final Function setItemId;

  /// The load item
  final Function loadItem;
}
