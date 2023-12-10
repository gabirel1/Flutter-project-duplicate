import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/Models/item.dart';
import 'package:my_app/Models/order.dart';
import 'package:my_app/Pages/article_page.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/ViewModels/basket_view_model.dart';
import 'package:my_app/Tools/color.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => BasketPageState();
}

class BasketPageState extends State<BasketPage> {
  final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BasketViewModel>(
      converter: BasketViewModel.factory,
      builder: (BuildContext context, BasketViewModel viewModel) {
        return Scaffold(
          key: drawerScaffoldKey,
          body: SafeArea(
            child: viewModel.orders.isEmpty
                ? buildEmptyBasket()
                : ListView.builder(
                    itemCount: viewModel.orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildBasket(
                          viewModel, viewModel.orders.elementAt(index), index);
                    },
                  ),
          ),
        );
      },
    );
  }

  Widget buildEmptyBasket() => Center(
        widthFactor: MediaQuery.of(context).size.width * 0.80,
        heightFactor: MediaQuery.of(context).size.height * 0.65,
        child: Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            const Text(
              'Basket is empty',
              style: TextStyle(fontSize: 18),
            ),
            Icon(
              Icons.sentiment_dissatisfied_outlined,
              color: MyColor.myBlack.withOpacity(0.25),
              size: MediaQuery.of(context).size.width * 0.3,
            ),
          ],
        ),
      );

  Widget buildBasket(BasketViewModel viewModel, Order order, int index) => SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
        child: GestureDetector(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: MyColor.myGrey,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: buildItem(viewModel, order, index),
          ),
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute<ArticlePage>(
                builder: (BuildContext context) => ArticlePage(
                  item: order.item,
                  index: index,
                ),
              ),
            );
          },
        ),
      ),);

  Widget buildItem(BasketViewModel viewModel, Order order, int index) =>
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
        child: Row(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: buildItemImage(order.item.images[0]),
            ),
            Expanded(
              flex: 5,
              child: buildItemData(order.item),
            ),
            Expanded(
              flex: 3,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  buildItemQuantity(viewModel, order),
                  IconButton(
                    onPressed: () {
                      viewModel.removeItem(order);
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

  Widget buildItemImage(String image) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              //image.isNotEmpty
              //? image
              /*:*/
              'https://www.fluttercampus.com/img/4by3.webp',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          );
        },
      );

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

  Widget buildItemDescription(String description) => Flexible(
        flex: 3,
        child: Text(
          description,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: TextStyle(
            fontSize: 14,
            color: MyColor.myBlack.withOpacity(0.25),
          ),
        ),
      );

  Widget buildItemQuantity(BasketViewModel viewModel, Order order) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: IconButton(
              onPressed: () {
                viewModel.addItemUnit(order);
              },
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.add),
            ),
          ),
          Flexible(child: Text(order.quantity.toString())),
          Flexible(
            child: IconButton(
              onPressed: () {
                viewModel.removeItemUnit(order);
              },
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.remove),
            ),
          ),
        ],
      );
}
