abstract class SignupEvent {}

// Signup

class UsernameAddedEvent extends SignupEvent {
  String username;
  UsernameAddedEvent({this.username = ''});
}

class PasswordAddedEvent extends SignupEvent {
  String password;
  PasswordAddedEvent({this.password = ''});
}

class MailAddedEvent extends SignupEvent {
  String mail;
  MailAddedEvent({this.mail = ''});
}

class SignUpFormBeingSubmittedEvent extends SignupEvent {
  bool isSignupFormSubmitted;
  SignUpFormBeingSubmittedEvent({this.isSignupFormSubmitted = false});
}

class BackToLoginNavigationEvent extends SignupEvent {
  bool isBackToNavigationButtonPressed;
  BackToLoginNavigationEvent({this.isBackToNavigationButtonPressed = false});
}

class SignupFormSuccesfulSubmissionEvent extends SignupEvent {}

class SignupFormFailureSubmissionEvent extends SignupEvent {}
