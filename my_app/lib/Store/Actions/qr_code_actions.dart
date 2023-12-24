import 'package:my_app/Models/item.dart';

/// The qr_code item action
class QrCodeItemIdAction {
  /// The qr_code item action
  QrCodeItemIdAction({required this.itemId});

  /// The item Id
  String itemId;
}

/// The qr_code load item action
class QrCodeLoadItemAction {
  /// The qr_code load item action
  QrCodeLoadItemAction({required this.item});

  /// The item
  Item item;
}
