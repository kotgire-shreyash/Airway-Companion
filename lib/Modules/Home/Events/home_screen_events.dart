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
