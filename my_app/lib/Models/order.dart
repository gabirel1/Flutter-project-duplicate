
import 'package:json_annotation/json_annotation.dart';

import 'package:my_app/Models/item.dart';

part 'order.g.dart';

typedef OrderList = List<Order>;
typedef OrderSet = Set<Order>;

@JsonSerializable()
class Order {
  Order({
    required this.item,
    required this.quantity,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Item item;
  int quantity = 0;

  @override
  bool operator==(Object other) {
    return (other is Order) && other.item.id == item.id;
  }

  @override
  int get hashCode => Object.hash(item.hashCode, quantity.hashCode);

}
