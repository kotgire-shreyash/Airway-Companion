class HomeScreenState {
  bool isSearchIconPressed;
  bool isSearchBoxTextFieldEnabled;
  bool isChecklistTilePressed;

  HomeScreenState({
    this.isSearchIconPressed = false,
    this.isSearchBoxTextFieldEnabled = false,
    this.isChecklistTilePressed = false,
  });

  HomeScreenState copyWith(
      {var isSearchIconPressed,
      var isSearchBoxTextFieldEnabled,
      var isChecklistTilePressed}) {
    return HomeScreenState(
      isSearchIconPressed: isSearchIconPressed ?? this.isSearchIconPressed,
      isSearchBoxTextFieldEnabled:
          isSearchBoxTextFieldEnabled ?? this.isSearchBoxTextFieldEnabled,
      isChecklistTilePressed:
          isChecklistTilePressed ?? this.isChecklistTilePressed,
    );
  }
}
