import 'package:my_app/Models/order.dart';

class BasketAddOrderAction {
  BasketAddOrderAction({required this.order});

  Order order;
}

class BasketAddOrderUnitAction {
  BasketAddOrderUnitAction({required this.order});

  final Order order;
}

class BasketRemoveOrderAction {
  BasketRemoveOrderAction({required this.order});

  final Order order;
}

class BasketRemoveOrderUnitAction {
  BasketRemoveOrderUnitAction({required this.order});

  final Order order;
}