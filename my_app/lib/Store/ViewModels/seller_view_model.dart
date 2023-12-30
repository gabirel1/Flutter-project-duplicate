import 'package:image_picker/image_picker.dart';
import 'package:my_app/Models/item.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/Actions/market_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

/// The basket view model
class SellerViewModel {
  /// The basket view model
  SellerViewModel({required this.validateForm});

  /// userUUID

  /// The basket view model factory
  factory SellerViewModel.factory(Store<AppState> store) {

    return SellerViewModel(
      validateForm: (Map<String, dynamic> form) async {
        final List<String> images = <String>[];
        final List<dynamic> photos = form['photos'];
        for (int i = 0; i < photos.length; i++) {
          await FirestoreService().addItemImageToStorage(photos[i] as XFile).then(((bool, String) value) => <void>{
            if (value.$1) <void>{
              images.add(value.$2),
            },
          },);
        }
        final bool success = await FirestoreService().sellerAddItem(form['Name'], form['Description'], double.parse(form['Price']),  images);

        if (success) {
          final ItemList response = await FirestoreService().getItems();
          store.dispatch(MarketItemsListAction(items: response));
        }
        return success;
      }
    );
  }

  /// Validate form
  final Function validateForm;

}
