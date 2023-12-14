import 'package:my_app/Store/State/home_state.dart';

/// The home change page action
class HomeChangePageAction {
  /// Change the page
  HomeChangePageAction({required this.page});

  /// The page to change
  final Pages page;
}
