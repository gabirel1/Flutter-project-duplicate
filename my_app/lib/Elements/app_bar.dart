import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/Models/item.dart';
import 'package:my_app/Pages/article_page.dart';
import 'package:my_app/Pages/qr_code_page.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/ViewModels/search_view_model.dart';
import 'package:my_app/Tools/color.dart';
import 'package:redux/redux.dart';

/// app bar
class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// app bar
  const MyAppBar({
    super.key,
  });

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(72);
}

class _MyAppBarState extends State<MyAppBar> {
  String searchItem = '';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SearchViewModel>(
      converter: (Store<AppState> store) => SearchViewModel.factory(
        store,
        FirestoreService(),
      ),
      onInitialBuild: (SearchViewModel viewModel) {
        viewModel.loadItems();
      },
      builder: (BuildContext context, SearchViewModel viewModel) {
        return AppBar(
          backgroundColor: MyColor().myBlue,
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
          title: Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: MyColor().myWhite,
            ),
            child: Row(
              children: <Widget>[
                buildSearchButton(viewModel),
                buildSearchBar(viewModel),
                buildQrCodeButton(),
              ],
            ),
          ),
          centerTitle: false,
          elevation: 2,
        );
      },
    );
  }

  // Widget Seach Button Padding
  Widget buildSearchButton(SearchViewModel viewModel) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 4, 4),
        child: IconButton(
          onPressed: () async {
            await showSearch(
              context: context,
              delegate: CustomSearchDelegate(viewModel.items),
            );
          },
          icon: const Icon(Icons.search),
        ),
      );

  // Widget Search Bar Expanded
  Widget buildSearchBar(SearchViewModel viewModel) => Expanded(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
          child: GestureDetector(
            child: Text(
              'Search Item...',
              style: TextStyle(
                color: MyColor().myBlack,
                fontSize: 18,
              ),
            ),
            onTap: () async => <void>{
              await showSearch(
                context: context,
                delegate: CustomSearchDelegate(viewModel.items),
              ),
            },
          ),
        ),
      );

  // Widget Qr Code Button Padding
  Widget buildQrCodeButton() => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 8, 4),
        child: GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const QrCode(),
              ),
            );
          },
          child: Icon(
            Icons.qr_code_outlined,
            color: MyColor().myBlack,
            size: 32,
          ),
        ),
      );
}

/// Searching
class CustomSearchDelegate extends SearchDelegate<void> {
  /// Constructor
  CustomSearchDelegate(this.items);

  /// List<Item> items
  final List<Item> items;

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(
          context,
          null,
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    /// List<String> matchQuery
    final List<String> matchQueryTitle = <String>[];
    final List<String> matchQueryId = <String>[];
    final List<Item> matchQueryItem = <Item>[];
    for (final Item item in items) {
      if (item.title.toLowerCase().contains(query.toLowerCase())) {
        matchQueryTitle.add(item.title);
        matchQueryId.add(item.id);
        matchQueryItem.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQueryTitle.length,
      itemBuilder: (BuildContext context, int index) {
        final String result = matchQueryTitle[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> matchQueryTitle = <String>[];
    final List<String> matchQueryId = <String>[];
    final List<Item> matchQueryItem = <Item>[];
    for (final Item item in items) {
      if (item.title.toLowerCase().contains(query.toLowerCase())) {
        matchQueryTitle.add(item.title);
        matchQueryId.add(item.id);
        matchQueryItem.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQueryTitle.length,
      itemBuilder: (BuildContext context, int index) {
        final String resultTitle = matchQueryTitle[index];
        final String resultId = matchQueryId[index];
        final Item resultItem = matchQueryItem[index];
        return ListTile(
          title: Text(resultTitle),
          onTap: () async => <void>{
            debugPrint('The title of the item clicked is : $resultTitle'),
            debugPrint('The id of the item clicked is : $resultId'),
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return ArticlePage(
                    item: resultItem,
                  );
                },
              ),
            ),
          },
        );
      },
    );
  }
}
