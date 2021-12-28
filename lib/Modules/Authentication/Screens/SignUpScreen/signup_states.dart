class SignupState {
  var username;
  var password;
  var mail;
  bool isFormSubmitted;
  bool isBackToNavigationButtonPressed;

  // 0 => neutral state, 1 => success state, 2 => failure state
  var internalStateValue;

  // Getters
  bool get isUsernameValid => username.length > 3;
  bool get isPasswordValid => password.length > 7;

  // Default constructor
  SignupState({
    this.username,
    this.mail,
    this.password,
    this.isFormSubmitted = true,
    this.internalStateValue = 0,
    this.isBackToNavigationButtonPressed = false,
  });

  // Copywith constructor
  SignupState copyWith({
    var username,
    var mail,
    var password,
    var isFormSubmitted,
    var displayToastByValue,
    var isBackToNavigationButtonPressed,
  }) {
    return SignupState(
      username: username ?? this.username,
      mail: mail ?? this.mail,
      password: password ?? this.password,
      isFormSubmitted: isFormSubmitted ?? this.isFormSubmitted,
      internalStateValue: displayToastByValue ?? internalStateValue,
      isBackToNavigationButtonPressed: isBackToNavigationButtonPressed ??
          this.isBackToNavigationButtonPressed,
    );
  }
}
