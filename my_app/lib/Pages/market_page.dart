import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/Elements/app_bar.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/ViewModels/market_view_model.dart';
import 'package:my_app/Tools/color.dart';
import 'package:redux/redux.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => MarketPageState();
}

class MarketPageState extends State<MarketPage> {
  final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MarketViewModel>(
      converter: (Store<AppState> store) =>
          MarketViewModel.factory(store, FirestoreService()),
      onInitialBuild: (MarketViewModel viewModel) {
        viewModel.loadItems();
      },
      builder: (BuildContext context, MarketViewModel viewModel) {
        return StoreConnector<AppState, MarketViewModel>(
          converter: (Store<AppState> store) => MarketViewModel.factory(store, FirestoreService()),
          builder: (BuildContext context, MarketViewModel viewModel) {
            return Scaffold(
                key: drawerScaffoldKey,
                body: viewModel.items.isEmpty
                    ? const Text('ça charge....')
                    : ListView.builder(
                  itemCount: viewModel.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(viewModel.items.elementAt(index).title);
                  },
                ),
                appBar: const MyAppBar(),
                backgroundColor: MyColor().myWhite,
            );
          },
        );
      },
    );
  }
}
