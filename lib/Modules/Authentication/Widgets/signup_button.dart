import 'package:airwaycompanion/Logic/Bloc/AuthenticationBloc/signup_bloc.dart';
import 'package:airwaycompanion/Modules/Authentication/Events/signup_events.dart';
import 'package:airwaycompanion/Modules/Authentication/Screens/SignUpScreen/signup_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpButton extends StatefulWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  _SignUpButtonState createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
      return ElevatedButton(
          child: state.internalStateValue == 1
              ? const Icon(
                  Icons.done,
                  color: Colors.white,
                )
              : state.isFormSubmitted
                  ? const Text(
                      "sign up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white),
                    )
                  : const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      )),
          style: TextButton.styleFrom(
            minimumSize: const Size(230, 45),
            primary: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.elliptical(30, 30),
              ),
            ),
            backgroundColor: const Color.fromRGBO(87, 77, 245, 2),
            // shape: const StadiumBorder(),
          ),
          onPressed: () {
            context.read<SignupBloc>().add(
                SignUpFormBeingSubmittedEvent(isSignupFormSubmitted: true));
          });
    });
  }
}