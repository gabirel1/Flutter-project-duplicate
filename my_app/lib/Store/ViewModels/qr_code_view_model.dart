import 'package:my_app/Models/item.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/Actions/basket_actions.dart';
import 'package:my_app/Store/Actions/market_actions.dart';
import 'package:my_app/Store/Actions/qr_code_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

class QrCodeViewModel {
  QrCodeViewModel({
    required this.itemId,
    required this.setItemId,
  });

  factory QrCodeViewModel.factory(
    Store<AppState> store,
    FirestoreService firestore,
  ) {
    return QrCodeViewModel(
      itemId: store.state.qrCode.itemId,
      setItemId: (String itemId) {
        store.dispatch(QrCodeItemIdAction(itemId: itemId));
      },
    );
  }

  final String itemId;
  final Function setItemId;
}
