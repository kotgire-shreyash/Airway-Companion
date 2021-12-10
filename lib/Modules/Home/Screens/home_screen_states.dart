class HomeScreenState {
  bool isSearchIconPressed;
  bool isSearchBoxTextFieldEnabled;

  HomeScreenState(
      {this.isSearchIconPressed = false,
      this.isSearchBoxTextFieldEnabled = false});

  HomeScreenState copyWith(
      {var isSearchIconPressed, var isSearchBoxTextFieldEnabled}) {
    return HomeScreenState(
      isSearchIconPressed: isSearchIconPressed ?? this.isSearchIconPressed,
      isSearchBoxTextFieldEnabled:
          isSearchBoxTextFieldEnabled ?? this.isSearchBoxTextFieldEnabled,
    );
  }
}
