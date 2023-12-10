import 'package:my_app/Models/item.dart';
import 'package:my_app/Models/order.dart';

class BasketState {
  BasketState({
    required this.orders,
  });

  factory BasketState.initial() => BasketState(
        orders: <Order>{
          Order(
            item: Item(
              id: 0,
              description:
                  "Ceci est un très bon objet que je vous conseil d'acheter le plus rapidement possible",
              title: 'La zaza ULTRA RARE A VENDRE',
              seller: 'PinkyDoll',
              images: <String>['Image'],
              price: 5.99,
            ),
            quantity: 2,
          ),
        },
      );

  OrderSet orders;
}
