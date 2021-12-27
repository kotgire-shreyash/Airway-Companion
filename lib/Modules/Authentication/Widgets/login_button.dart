import 'package:airwaycompanion/Logic/Bloc/AuthenticationBloc/login_bloc.dart';
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
              Colors.blue.shade700,
              Colors.blue.shade500,
              Colors.blue.shade500,
              Colors.blue.shade700,
            ],
            stops: const [
              0.1,
              0.3,
              0.6,
              0.9,
            ],
          ),
        ),
        child: ElevatedButton(
          child: context.read<LoginBloc>().state.internalStateValue == 1
              ? const Icon(
                  Icons.done,
                  color: Colors.white,
                )
              : context.read<LoginBloc>().state.isFormSubmitted
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
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      )),
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 5,
          ),
          onPressed: () {
            // context.read<LoginBloc>().add(
            //     LoginFormBeingSubmittedEvent(isLoginFormSubmitted: true));

            Navigator.pushNamed(context, "home");
          },
        ),
      ),
    );
  }
}
