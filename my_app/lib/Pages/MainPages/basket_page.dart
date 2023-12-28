import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/Models/item.dart';
import 'package:my_app/Models/order_item.dart';
import 'package:my_app/Pages/article_page.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/ViewModels/basket_view_model.dart';
import 'package:my_app/Tools/color.dart';
import 'package:rive/rive.dart' hide LinearGradient;

/// The basket page
class BasketPage extends StatefulWidget {
  /// The basket page
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => BasketPageState();
}

/// The basket page state
class BasketPageState extends State<BasketPage> {
  /// The basket page state
  final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BasketViewModel>(
      converter: BasketViewModel.factory,
      builder: (BuildContext context, BasketViewModel viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                const Text('Total:'),
                const SizedBox(
                  width: 8,
                ),
                Text('${viewModel.order.totalPrice.toString()} €'),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  if (await viewModel.checkout(viewModel.order) == false) {
                    await buildShowDialogLogin();
                  } else {
                    await buildShowDialogSuccessfulCheckout();
                  }
                },
                child: const Row(
                  children: <Widget>[
                    Text('Checkout'),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.payments_sharp),
                  ],
                ),
              ),
            ],
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    MyColor().myGreen,
                    MyColor().myBlue,
                  ],
                  stops: const <double>[0, 1],
                  begin: AlignmentDirectional.centerEnd,
                  end: AlignmentDirectional.bottomStart,
                ),
              ),
            ),
          ),
          key: drawerScaffoldKey,
          body: SafeArea(
            child: viewModel.order.items.isEmpty
                ? buildEmptyBasket()
                : ListView.builder(
                    itemCount: viewModel.order.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildBasket(
                        viewModel,
                        viewModel.order.items.elementAt(index),
                        index,
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

  /// buildEmptyBasket
  Widget buildEmptyBasket() => Center(
        widthFactor: MediaQuery.of(context).size.width * 0.80,
        heightFactor: MediaQuery.of(context).size.height * 0.65,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 1,
              child: const RiveAnimation.asset(
                'assets/animations/empty_basket.riv',
              ),
            ),
            const Text(
              'Basket is empty',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  /// buildBasket
  Widget buildBasket(BasketViewModel viewModel, OrderItem item, int index) =>
      SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
          child: GestureDetector(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: MyColor().myGrey,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: buildItem(viewModel, item, index),
            ),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute<ArticlePage>(
                  builder: (BuildContext context) => ArticlePage(
                    item: item.item,
                  ),
                ),
              );
            },
          ),
        ),
      );

  /// buildItem
  Widget buildItem(BasketViewModel viewModel, OrderItem item, int index) =>
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: buildItemImage(item.item.images[0]),
            ),
            Expanded(
              flex: 5,
              child: buildItemData(item.item),
            ),
            Expanded(
              flex: 3,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  buildItemQuantity(viewModel, item),
                  IconButton(
                    onPressed: () {
                      viewModel.removeItem(item);
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  /// buildItemData
  Widget buildItemData(Item item) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildItemTitle(item.title),
            buildItemDescription(item.description),
          ],
        ),
      );

  /// buildItemImage
  Widget buildItemImage(String image) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              //image.isNotEmpty
              //? image
              /*:*/
              // 'https://www.fluttercampus.com/img/4by3.webp',
              (image.isNotEmpty && image != '')
                  ? image
                  : 'https://www.fluttercampus.com/img/4by3.webp',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          );
        },
      );

  /// buildItemTitle
  Widget buildItemTitle(String title) => Flexible(
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  /// buildItemDescription
  Widget buildItemDescription(String description) => Flexible(
        flex: 3,
        child: Text(
          description,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: TextStyle(
            fontSize: 14,
            color: MyColor().myBlack.withOpacity(0.25),
          ),
        ),
      );

  /// buildItemQuantity
  Widget buildItemQuantity(BasketViewModel viewModel, OrderItem order) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: IconButton(
              onPressed: () {
                viewModel.addUnit(order);
              },
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.add),
            ),
          ),
          Flexible(child: Text(order.quantity.toString())),
          Flexible(
            child: IconButton(
              onPressed: () {
                viewModel.removeUnit(order);
              },
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.remove),
            ),
          ),
        ],
      );

  /// Widget Future show dialog Error
  Future<dynamic> buildShowDialogLogin() => showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Log in first',
              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            backgroundColor: MyColor().myGrey,
          );
        },
      );

  /// Widget Future show dialog order placed
  Future<dynamic> buildShowDialogSuccessfulCheckout() => showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          Future<void>.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              Navigator.of(context).pop(true);
            }
          });
          return AlertDialog(
            title: const Text(
              'Your order has been placed',
              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            backgroundColor: MyColor().myGrey,
          );
        },
      );
}
