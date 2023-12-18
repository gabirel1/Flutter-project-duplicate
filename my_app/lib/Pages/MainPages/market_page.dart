import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/Elements/app_bar.dart';
import 'package:my_app/Models/item.dart';
import 'package:my_app/Pages/article_page.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/ViewModels/market_view_model.dart';
import 'package:my_app/Tools/color.dart';
import 'package:redux/redux.dart';

/// The market page
class MarketPage extends StatefulWidget {
  /// The market page
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => MarketPageState();
}

/// The market page state
class MarketPageState extends State<MarketPage> {
  /// The market page state
  final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MarketViewModel>(
      converter: (Store<AppState> store) => MarketViewModel.factory(
        store,
        FirestoreService(),
      ),
      onInitialBuild: (MarketViewModel viewModel) {
        viewModel.loadItems();
      },
      builder: (BuildContext context, MarketViewModel viewModel) {
        return Scaffold(
          key: drawerScaffoldKey,
          body: viewModel.items.isEmpty
              ? const Text('ça charge....')
              : ListView.builder(
                  itemCount: viewModel.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildItem(
                      viewModel.items.elementAt(index),
                      index,
                    );
                  },
                ),
          appBar: const MyAppBar(),
          backgroundColor: MyColor().myWhite,
        );
      },
    );
  }

  /// Widget item Padding
  ///
  /// @param [item] is the item with the title, the description, the seller's name, the list of images and the price
  Widget buildItem(Item item, int index) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 5, 20, 5),
        child: GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(
              // ignore: always_specify_types
              MaterialPageRoute(
                builder: (BuildContext context) => ArticlePage(
                  item: item,
                ),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(
                color: MyColor().myGrey,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget>[
                buildImageItem(item.images[0]),
                buildTitleItem(item.title),
                buildPriceItem(item.price),
              ],
            ),
          ),
        ),
      );

  /// Widget item image Padding
  ///
  /// @param [image] is the first image of the item
  Widget buildImageItem(String image) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            image.isNotEmpty
                ? image
                : 'https://www.fluttercampus.com/img/4by3.webp',
            width: 200,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
      );

  /// Widget item title Padding
  ///
  /// @param [title] is the title of the item
  Widget buildTitleItem(String title) => Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Text(
          title.toString(),
          style: const TextStyle(
            fontSize: 18,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );

  /// Widget item price Padding
  ///
  /// @param [price] is the price of the item
  Widget buildPriceItem(double price) => Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Text(
          '$price €',
        ),
      );
}
