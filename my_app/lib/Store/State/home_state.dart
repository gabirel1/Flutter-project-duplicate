

enum Pages {
  market, basket, profile
}

class HomeState {

  HomeState({required this.page});

  factory HomeState.initial() => HomeState(
    page: Pages.market,
  );

  Pages page ;
}
