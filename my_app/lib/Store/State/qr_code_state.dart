import 'package:my_app/Models/item.dart';

/// class QrCodeState
class QrCodeState {
  /// QrCodeState
  QrCodeState({
    required this.itemId,
    required this.item,
  });

  /// QrCodeState.initial
  factory QrCodeState.initial() => QrCodeState(
        itemId: '',
        item: Item(
          id: '',
          description: '',
          title: '',
          seller: '',
          sellerUUID: '',
          images: <String>[],
          price: 0,
        ),
      );

  /// variable itemId
  String itemId;

  /// variable item
  Item item;
}
