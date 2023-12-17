import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

/// Item list is a list of Item
typedef ItemList = List<Item>;

/// Item is a class that represent an item
@JsonSerializable()
class Item {
  /// Item has an id, a description, a title, a seller, a list of images and a price
  Item({
    required this.id,
    required this.description,
    required this.title,
    required this.seller,
    required this.images,
    required this.price,
  });

  /// Item from json
  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  /// Item to json
  Map<String, dynamic> toJson() => _$ItemToJson(this);

  /// Item id
  String id = '';

  /// Item description
  String description = '';

  /// Item title
  String title = '';

  /// Item seller
  String seller = '';

  /// Item images
  List<String> images = <String>[];

  /// Item price
  double price = 0;
}
