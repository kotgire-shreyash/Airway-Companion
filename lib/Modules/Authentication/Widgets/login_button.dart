import 'package:airwaycompanion/Logic/Bloc/AuthenticationBloc/login_bloc.dart';
import 'package:airwaycompanion/Modules/Authentication/Screens/LoginScreen/login_states.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return ElevatedButton(
          child: state.internalStateValue == 1
              ? const Icon(
                  Icons.done,
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
            backgroundColor: Colors.blue.shade900,
            // shape: const StadiumBorder(),
          ),
          onPressed: () async {
            // context.read<LoginBloc>().add(
            //     LoginFormBeingSubmittedEvent(isLoginFormSubmitted: true));

            Navigator.pushNamed(context, "home");
          },
        );
      },
    );
  }
}
