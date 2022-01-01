class HomeScreenState {
  bool isSearchIconPressed;
  bool isTimeLineButtonPressed;
  bool isSearchBoxTextFieldEnabled;
  bool isChecklistTilePressed;
  bool isNavigationTilePressed;

  HomeScreenState({
    this.isSearchIconPressed = false,
    this.isSearchBoxTextFieldEnabled = false,
    this.isChecklistTilePressed = false,
    this.isNavigationTilePressed = false,
    this.isTimeLineButtonPressed = false,
  });

  HomeScreenState copyWith({
    var isSearchIconPressed,
    var isSearchBoxTextFieldEnabled,
    var isChecklistTilePressed,
    var isNavigationTilePressed,
    var isTimeLineButtonPressed,
  }) {
    return HomeScreenState(
      isSearchIconPressed: isSearchIconPressed ?? this.isSearchIconPressed,
      isSearchBoxTextFieldEnabled:
          isSearchBoxTextFieldEnabled ?? this.isSearchBoxTextFieldEnabled,
      isChecklistTilePressed:
          isChecklistTilePressed ?? this.isChecklistTilePressed,
      isNavigationTilePressed:
          isNavigationTilePressed ?? this.isNavigationTilePressed,
      isTimeLineButtonPressed:
          isTimeLineButtonPressed ?? this.isTimeLineButtonPressed,
    );
  }
}
