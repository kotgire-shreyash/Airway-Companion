import 'package:airwaycompanion/Logic/Bloc/AuthenticationBloc/login_bloc.dart';
import 'package:airwaycompanion/Modules/Authentication/Events/login_events.dart';
import 'package:airwaycompanion/Modules/Authentication/Screens/LoginScreen/login_states.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
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
              Colors.blue.shade600,
              Colors.lightBlue,
              Colors.lightBlue,
              Colors.blue.shade600,
            ],
            stops: const [
              0.2,
              0.4,
              0.6,
              0.8,
            ],
          ),
        ),
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          return ElevatedButton(
            child: state.internalStateValue == 1
                ? const Icon(
                    Icons.done_rounded,
                    color: Colors.white,
                  )
                : state.isFormSubmitted
                    ? const Text(
                        "login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      )
                    : const SizedBox(
                        height: 20,
                        width: 20,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        )),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 5,
            ),
            onPressed: () {
              context.read<LoginBloc>().add(
                  LoginFormBeingSubmittedEvent(isLoginFormSubmitted: true));
            },
          );
        }),
      ),
    );
  }
}
