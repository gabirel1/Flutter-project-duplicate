import 'package:json_annotation/json_annotation.dart';
import 'package:my_app/Models/order_item.dart';

part 'my_orders.g.dart';

/// Order list is a list of Order
typedef OrderList = List<MyOrder>;

/// Order is a class that represent an order
@JsonSerializable()
class MyOrder {
  /// Order has an userID, a list of items and a date
  MyOrder({
    required this.userID,
    required this.items,
    required this.orderedAt,
    required this.totalPrice,
  });

  /// Order from json
  factory MyOrder.fromJson(Map<String, dynamic> json) =>
      _$MyOrderFromJson(json);

  /// Order to json
  Map<String, dynamic> toJson() => _$MyOrderToJson(this);

  /// Order userID
  String userID = '';

  /// Order items
  List<OrderItem> items = <OrderItem>[];

  /// Order orderedAt
  String orderedAt = '';

  /// Order totalPrice
  double totalPrice = 0;
}
