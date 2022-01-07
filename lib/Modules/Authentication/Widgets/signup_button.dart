import 'package:airwaycompanion/Logic/Bloc/AuthenticationBloc/signup_bloc.dart';
import 'package:airwaycompanion/Modules/Authentication/Events/signup_events.dart';
import 'package:airwaycompanion/Modules/Authentication/Screens/SignUpScreen/signup_states.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/custom_colors.dart';
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
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Container(
        height: 45,
        width: 230,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.redAccent.shade400,
              Colors.redAccent.shade200,
              Colors.redAccent.shade200,
              Colors.redAccent.shade400,
            ],
            stops: const [
              0.1,
              0.3,
              0.7,
              0.9,
            ],
          ),
        ),
        child: BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
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
                          strokeWidth: 3,
                        )),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 5,
            ),
            onPressed: () {
              context.read<SignupBloc>().add(
                  SignUpFormBeingSubmittedEvent(isSignupFormSubmitted: true));
            },
          );
        }),
      ),
    );
  }
}
