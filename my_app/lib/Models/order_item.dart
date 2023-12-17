import 'package:json_annotation/json_annotation.dart';
import 'package:my_app/Models/item.dart';

part 'order_item.g.dart';

/// OrderItem is a class that represent an order item
@JsonSerializable()
class OrderItem {
  /// OrderItem has an item and a quantity
  OrderItem({
    required this.item,
    required this.quantity,
  });

  /// OrderItem from json
  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  /// OrderItem to json
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  /// OrderItem item
  Item item;

  /// OrderItem quantity
  int quantity;
}
