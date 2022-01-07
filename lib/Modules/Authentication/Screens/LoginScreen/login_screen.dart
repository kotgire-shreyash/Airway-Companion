import 'package:airwaycompanion/Logic/Bloc/AuthenticationBloc/login_bloc.dart';
import 'package:airwaycompanion/Modules/Authentication/Screens/LoginScreen/login_states.dart';
import 'package:airwaycompanion/Modules/Authentication/Widgets/login_button.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/custom_colors.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Events/login_events.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageViewState createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  final _formKey = GlobalKey();
  final _latoFontFamily = GoogleFonts.lato().fontFamily;
  final _latoBoldFontFamily =
      GoogleFonts.lato(fontWeight: FontWeight.bold).fontFamily;

  @override
  void initState() {
    super.initState();
    CustomFlutterToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state.internalStateValue == 1) {
          CustomFlutterToast.init(context);
          CustomFlutterToast.display("Logged in");
          await Future.delayed(const Duration(seconds: 2));
          Navigator.pushReplacementNamed(context, "home");
        }
      },
      child: _loginForm(),
    );
  }

  //? Main Login Form
  Widget _loginForm() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SafeArea(child: _loginIndicatorImage()),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _titleText(),
                      _sizedBoxSpace(20),
                      _usernameTextField(),
                      _mailTextField(),
                      _passwordTextField(),
                      _sizedBoxSpace(20),
                      _passwordReset(),
                      _sizedBoxSpace(25),
                      const LoginButton(),
                      _signupIndicator()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //? Title
  Widget _titleText() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              state.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 30,
                fontFamily:
                    GoogleFonts.lato(fontWeight: FontWeight.w900).fontFamily,
              ),
            ));
      },
    );
  }

  //? Const Space widget
  Widget _sizedBoxSpace(double height) {
    return SizedBox(
      height: height,
    );
  }

  //? Username Field
  Widget _usernameTextField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: false,
          autofocus: false,
          style: TextStyle(
            fontFamily: _latoFontFamily,
          ),
          decoration: InputDecoration(
            hintText: "username",
            labelText: "Username",
            labelStyle: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade500,
                fontFamily: _latoFontFamily),
            hintStyle: TextStyle(
                color: Colors.grey.shade300, fontFamily: _latoFontFamily),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlue, width: 2.5)),
            icon: const Icon(
              Icons.person,
              color: Colors.lightBlue,
            ),
          ),
          validator: (value) {
            if (value == null) return "Username required";
            if (value.length < 3) return "Username is too short";
            return null;
          },
          onChanged: (value) {
            context
                .read<LoginBloc>()
                .add(UsernameChangedEvent(username: value));
          },
        );
      },
    );
  }

  //? Password field
  Widget _passwordTextField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: "password",
            labelText: "Password",
            labelStyle: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade500,
                fontFamily: _latoFontFamily),
            hintStyle: TextStyle(
                color: Colors.grey.shade300, fontFamily: _latoFontFamily),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlue, width: 2.5)),
            icon: const Icon(
              Icons.lock,
              color: Colors.lightBlue,
            ),
          ),
          validator: (value) {
            if (value == null) return "Password required";
            if (value.length < 3) return "Password is too short";
            return null;
          },
          onChanged: (value) {
            context
                .read<LoginBloc>()
                .add(PasswordChangedEvent(password: value));
          },
        );
      },
    );
  }

  //? Email Field
  Widget _mailTextField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: "email",
            labelText: "Email",
            labelStyle: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade500,
                fontFamily: _latoFontFamily),
            hintStyle: TextStyle(
                color: Colors.grey.shade300, fontFamily: _latoFontFamily),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlue, width: 2.5)),
            icon: const Icon(
              Icons.mail,
              color: Colors.lightBlue,
            ),
          ),
          validator: (value) {
            if (value == null) return "mail required";
            if (value.length < 3) return "Invalid mail";
            return null;
          },
          onChanged: (value) {
            context.read<LoginBloc>().add(MailChangedEvent(mail: value));
          },
        );
      },
    );
  }

  //? Password reset field
  Widget _passwordReset() {
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        "Forgot password?",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: _latoBoldFontFamily,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }

//? Login Screen Image
  Widget _loginIndicatorImage() {
    return Image.asset(
      "assets/images/login_image_lightBlue.png",
      fit: BoxFit.cover,
    );
  }

  //? Signup indicator
  Widget _signupIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: _latoFontFamily),
        ),
        TextButton(
          child: Text(
            "SignUp",
            style: TextStyle(
                color: Colors.lightBlue,
                fontFamily: _latoBoldFontFamily,
                fontWeight: FontWeight.w900),
          ),
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                  const Color.fromRGBO(95, 77, 250, 0.05))),
          onPressed: () {
            Navigator.pushNamed(context, "signup");
          },
        ),
      ],
    );
  }
}
