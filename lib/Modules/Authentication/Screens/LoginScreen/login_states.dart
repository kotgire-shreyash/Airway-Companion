class LoginState {
  var username;
  var password;
  var mail;
  String title;
  bool isFormSubmitted;
  bool isSignupPageNavigationCalled;

  // 0 => neutral state, 1 => success state, 2 => failure state
  var internalStateValue;

  bool get isUsernameValid => username.length > 3;
  bool get isPasswordValid => password.length > 7;

  LoginState(
      {this.username,
      this.password,
      this.mail,
      this.title = "Welcome ",
      this.isSignupPageNavigationCalled = false,
      this.internalStateValue = 0,
      this.isFormSubmitted = true});

  LoginState copyWith(
      {var username,
      var mail,
      var password,
      var isFormSubmitted,
      var internalStateValue,
      var isSignupPageNavigationCalled}) {
    return LoginState(
      username: username ?? this.username,
      mail: mail ?? this.mail,
      password: password ?? this.password,
      title: username == null
          ? "Welcome ${this.username == null || this.username.isEmpty ? "" : (this.username.length <= 10) ? this.username : this.username.substring(0, 9) + "..."}"
          : (username.length <= 9)
              ? "Welcome $username"
              : "Welcome ${username.substring(0, 8)}...",
      isFormSubmitted: isFormSubmitted ?? this.isFormSubmitted,
      isSignupPageNavigationCalled:
          isSignupPageNavigationCalled ?? this.isSignupPageNavigationCalled,
      internalStateValue: internalStateValue ?? this.internalStateValue,
    );
  }
}
