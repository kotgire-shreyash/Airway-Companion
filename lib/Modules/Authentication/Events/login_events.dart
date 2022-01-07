abstract class LoginEvent {}

class UsernameChangedEvent extends LoginEvent {
  String username;
  UsernameChangedEvent({this.username = ''});
}

class MailChangedEvent extends LoginEvent {
  String mail;
  MailChangedEvent({this.mail = ''});
}

class PasswordChangedEvent extends LoginEvent {
  String password;
  PasswordChangedEvent({this.password = ''});
}

class SignupPageNavigationEvent extends LoginEvent {
  bool isSignupPageNavigationCalled;
  SignupPageNavigationEvent({this.isSignupPageNavigationCalled = false});
}

class LoginFormBeingSubmittedEvent extends LoginEvent {
  bool isLoginFormSubmitted;
  LoginFormBeingSubmittedEvent({this.isLoginFormSubmitted = false});
}

class LoginFormSuccesfulSubmissionEvent extends LoginEvent {}

class LoginFormFailureSubmissionEvent extends LoginEvent {
  int code;
  LoginFormFailureSubmissionEvent({required this.code});
}
