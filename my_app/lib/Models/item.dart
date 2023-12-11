import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

typedef ItemList = List<Item>;

@JsonSerializable()
class Item {
  Item({
    required this.id,
    required this.description,
    required this.title,
    required this.seller,
    required this.images,
    required this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  int id = 0;
  String description = '';
  String title = '';
  String seller = '';
  List<String> images = <String>[];
  double price = 0;
}
