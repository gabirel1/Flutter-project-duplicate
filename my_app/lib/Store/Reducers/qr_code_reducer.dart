import 'package:my_app/Store/Actions/qr_code_actions.dart';
import 'package:my_app/Store/State/qr_code_state.dart';

/// QrCodeState qrCodeReducer
QrCodeState qrCodeReducer(QrCodeState state, dynamic action) {
  final QrCodeState newState = state;
  switch (action) {
    case final QrCodeItemIdAction action:
      newState.itemId = action.itemId;
      return newState;
    case final QrCodeLoadItemAction action:
      newState.item = action.item;
      return newState;
    default:
      return newState;
  }
}
