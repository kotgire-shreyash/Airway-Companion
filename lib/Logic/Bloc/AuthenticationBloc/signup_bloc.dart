import 'package:airwaycompanion/Modules/Authentication/Events/signup_events.dart';
import 'package:airwaycompanion/Modules/Authentication/Screens/SignUpScreen/signup_states.dart';
import 'package:airwaycompanion/Modules/Firebase/firebase.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState()) {
    on<UsernameAddedEvent>(_onUsernameAdded);
    on<PasswordAddedEvent>(_onPasswordAdded);
    on<MailAddedEvent>(_onMailAddedEvent);
    on<SignUpFormBeingSubmittedEvent>(_onSignupFormBeingSubmitted);
    on<BackToLoginNavigationEvent>(_onBackToNavigationButtonPressEvent);
  }

  void _onUsernameAdded(UsernameAddedEvent event, Emitter<SignupState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void _onMailAddedEvent(MailAddedEvent event, Emitter<SignupState> emit) {
    emit(state.copyWith(mail: event.mail));
  }

  void _onPasswordAdded(PasswordAddedEvent event, Emitter<SignupState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _signupFormSuccessfulSubmissionEvent(
      SignupFormSuccesfulSubmissionEvent event, Emitter<SignupState> emit) {
    emit(state.copyWith(isFormSubmitted: true, displayToastByValue: 1));
  }

  void _onBackToNavigationButtonPressEvent(
      BackToLoginNavigationEvent event, Emitter<SignupState> emit) {
    emit(state.copyWith(
        isFormSubmitted: true,
        isBackToNavigationButtonPressed:
            event.isBackToNavigationButtonPressed));
  }

  void _onSignupFormBeingSubmitted(
      SignUpFormBeingSubmittedEvent event, Emitter<SignupState> emit) async {
    emit(state.copyWith(isFormSubmitted: false));

    try {
      // Creating Signup profile
      await Firebase.firebaseAuthentication.createUserWithEmailAndPassword(
          email: state.mail, password: state.password);
      // Creating cloud firestore collection
      await Firebase.firebaseFirestoreInstance
          .collection("users")
          .doc("profiles")
          .collection("${state.mail}")
          .doc(Firebase.firebaseAuthentication.currentUser!.uid)
          .set({
        "fullname": "Not Set",
        "username": state.username,
        "mail": state.mail,
        "password": state.password,
        "mobile": "Not Set",
        "address": "Not Set"
      });

      _signupFormSuccessfulSubmissionEvent(
          SignupFormSuccesfulSubmissionEvent(), emit);
      CustomFlutterToast.display("Signed up");
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      CustomFlutterToast.display("Failed to sign up");
    }

    emit(state.copyWith(isFormSubmitted: true));
  }
}
