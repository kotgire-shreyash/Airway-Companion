import 'package:airwaycompanion/Modules/Authentication/Events/login_events.dart';
import 'package:airwaycompanion/Modules/Authentication/Screens/LoginScreen/login_states.dart';
import 'package:airwaycompanion/Modules/Firebase/firebase.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<UsernameChangedEvent>(_onUsernameChanged);
    on<MailChangedEvent>(_onMailChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
    on<LoginFormBeingSubmittedEvent>(_onLoginFormBeingSubmitted);
    on<SignupPageNavigationEvent>(_onSignupPageNavigationEvent);
  }

  void _onUsernameChanged(
      UsernameChangedEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void _onMailChanged(MailChangedEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(mail: event.mail));
  }

  void _onPasswordChanged(
      PasswordChangedEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onLoginFormBeingSubmitted(
      LoginFormBeingSubmittedEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isFormSubmitted: false));

    try {
      // Logging in
      await Firebase.firebaseAuthentication.signInWithEmailAndPassword(
          email: state.mail, password: state.password);
      emit(state.copyWith(internalStateValue: 1));
    } catch (e) {
      CustomFlutterToast.display("Failed to log in");
    }

    emit(state.copyWith(isFormSubmitted: true));
  }

  void _onSignupPageNavigationEvent(
      SignupPageNavigationEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(isSignupPageNavigationCalled: true));
  }
}
