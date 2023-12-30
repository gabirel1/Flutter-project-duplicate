import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/Pages/MainPages/basket_page.dart';
import 'package:my_app/Pages/MainPages/market_page.dart';
import 'package:my_app/Pages/MainPages/profile_page.dart';
import 'package:my_app/Pages/seller_page.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/ViewModels/home_view_model.dart';
import 'package:my_app/Tools/color.dart';
import 'package:redux/redux.dart';

/// The home page
class HomePage extends StatefulWidget {
  /// The home page
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

/// The home page state
class HomePageState extends State<HomePage> {
  /// The home page state
  final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      converter: (Store<AppState> store) =>
          HomeViewModel.factory(store, PageController()),
      onInitialBuild: (HomeViewModel viewModel) {
        viewModel.loadUser();
      },
      builder: (BuildContext context, HomeViewModel viewModel) {
        log(viewModel.user.toString());
        log(viewModel.user!.isSeller.toString());
        return Scaffold(
          body: PageView(
            controller: viewModel.pageController,
            onPageChanged: viewModel.changePage,
            children: <Widget>[
              const MarketPage(),
              const BasketPage(),
              const ProfilePage(),
              if (viewModel.user != null && viewModel.user!.isSeller)
                const SellerPage(),
            ],
          ),
          bottomNavigationBar: bottomNavigationBar(viewModel),
        );
      },
    );
  }

  /// The bottom navigation bar
  BottomNavigationBar bottomNavigationBar(HomeViewModel viewModel) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: MyColor().myWhite,
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket_outlined),
          label: 'Basket',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.account_box_outlined),
          label: 'Profile',
        ),
        if (viewModel.user != null && viewModel.user!.isSeller)
          const BottomNavigationBarItem(
            icon: Icon(Icons.payments_sharp),
            label: 'Sell',
          ),
      ],
      currentIndex: viewModel.page.index,
      selectedItemColor: MyColor().myBlue,
      onTap: viewModel.bottomTap,
    );
  }
}
