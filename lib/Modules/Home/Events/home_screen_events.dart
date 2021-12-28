abstract class HomeScreenEvent {}

//? Search icon tapped
class SearchIconPressed extends HomeScreenEvent {
  bool isSearchIconPressed;
  SearchIconPressed({this.isSearchIconPressed = false});
}

//? Search box text field conversion
class SearchBoxTextFieldPressed extends HomeScreenEvent {
  bool isSearchBoxTextFieldEnabled;
  SearchBoxTextFieldPressed({this.isSearchBoxTextFieldEnabled = false});
}

//? Timeline button pressed
class TimeLineButtonPressed extends HomeScreenEvent {
  bool isTimeLineButtonPressed;
  TimeLineButtonPressed({this.isTimeLineButtonPressed = false});
}

// Drawer Navigations
//? Check list tile pressed
class CheckListTilePressed extends HomeScreenEvent {
  bool isChecklistTilePressed;
  CheckListTilePressed({this.isChecklistTilePressed = false});
}

//? Navigation Tile pressed
class NavigationTilePressed extends HomeScreenEvent {
  bool isNavigationTilePressed;
  NavigationTilePressed({this.isNavigationTilePressed = false});
}
