class QrCodeState {
  QrCodeState({required this.itemId});

  factory QrCodeState.initial() => QrCodeState(
        itemId: '',
      );

  String itemId;
}
