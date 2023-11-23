
class ItemModel {
  ItemModel({
    required this.id,
      required this.description,
      required this.title,
      required this.seller,
      required this.images,
      required this.price,
  });

  int id = 0;
  String description = '';
  String title = '';
  String seller = '';
  List<String> images = <String>[];
  double price = 0;
}
