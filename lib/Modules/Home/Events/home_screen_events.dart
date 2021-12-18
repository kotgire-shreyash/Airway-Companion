abstract class HomeScreenEvent {}

class SearchIconPressed extends HomeScreenEvent {
  bool isSearchIconPressed;
  SearchIconPressed({this.isSearchIconPressed = false});
}

class SearchBoxTextFieldPressed extends HomeScreenEvent {
  bool isSearchBoxTextFieldEnabled;
  SearchBoxTextFieldPressed({this.isSearchBoxTextFieldEnabled = false});
}
