/// This file contains the state of the home page
enum Pages {
  /// The market page
  market,

  /// The basket page
  basket,

  /// The profile page
  profile,

  /// The seller page
  seller
}

/// The home state
class HomeState {
  /// The home state
  HomeState({required this.page});

  /// The home state initial
  factory HomeState.initial() => HomeState(
        page: Pages.market,
      );

  /// The page
  Pages page;
}
