import 'package:airwaycompanion/Logic/Bloc/AuthenticationBloc/signup_bloc.dart';
import 'package:airwaycompanion/Modules/Authentication/Events/signup_events.dart';
import 'package:airwaycompanion/Modules/Authentication/Screens/SignUpScreen/signup_states.dart';
import 'package:airwaycompanion/Modules/Authentication/Widgets/signup_button.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/custom_colors.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPageView extends StatefulWidget {
  const SignUpPageView({Key? key}) : super(key: key);

  @override
  _SignUpPageViewState createState() => _SignUpPageViewState();
}

class _SignUpPageViewState extends State<SignUpPageView> {
  final _formKey = GlobalKey();
  final _latoFontFamily = GoogleFonts.lato().fontFamily;
  final _latoBoldFontFamily =
      GoogleFonts.lato(fontWeight: FontWeight.w900).fontFamily;

  @override
  void initState() {
    super.initState();
    CustomFlutterToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) async {
        if (state.isBackToNavigationButtonPressed) {
          context.read<SignupBloc>().add(BackToLoginNavigationEvent(
              isBackToNavigationButtonPressed: false));
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return _signUpForm();
      },
    );
  }

  //? Main Login Form
  Widget _signUpForm() {
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
                SafeArea(child: _signUpIndicatorImage()),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _titleText(),
                      const SizedBox(
                        height: 20,
                      ),
                      _usernameTextField(),
                      _mailTextField(),
                      _passwordTextField(),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SignUpButton(),
                      _backToLoginIndicator(),
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: Text(
        "Sign Up",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: 30,
        ),
      ),
    );
  }

  //? Username Field
  Widget _usernameTextField() {
    return TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "username",
        labelText: "Username",
        labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade500),
        hintStyle: TextStyle(color: Colors.grey.shade300),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 2.5)),
        icon: Icon(
          Icons.person,
          color: CustomColors.signupSwatch,
        ),
      ),
      validator: (value) {
        if (value == null) return "Username required";
        if (value.length < 3) return "Username is too short";
        return null;
      },
      onChanged: (value) {
        context.read<SignupBloc>().add(UsernameAddedEvent(username: value));
      },
    );
  }

  //? Password field
  Widget _passwordTextField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: "password",
        labelText: "Password",
        labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade500),
        hintStyle: TextStyle(color: Colors.grey.shade300),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 2.5)),
        icon: Icon(
          Icons.lock,
          color: CustomColors.signupSwatch,
        ),
      ),
      validator: (value) {
        if (value == null) return "Password required";
        if (value.length < 8) return "Password is too short";
        return null;
      },
      onChanged: (value) {
        context.read<SignupBloc>().add(PasswordAddedEvent(password: value));
      },
    );
  }

  //? Email Field
  Widget _mailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "email",
        labelText: "Email",
        labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade500),
        hintStyle: TextStyle(color: Colors.grey.shade300),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 2.5)),
        icon: Icon(
          Icons.mail,
          color: CustomColors.signupSwatch,
        ),
      ),
      validator: (value) {
        if (value == null) return "Mail required";
        if (value.length < 3) return "Invalid mail";
        return null;
      },
      onChanged: (value) {
        context.read<SignupBloc>().add(MailAddedEvent(mail: value));
      },
    );
  }

//? Login Screen Image
  Widget _signUpIndicatorImage() {
    return Image.asset(
      "assets/images/signup_red_accent200.png",
      fit: BoxFit.cover,
    );
  }

  //? Signup indicator
  Widget _backToLoginIndicator() {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextButton(
          child: Text(
            "back to login",
            style:
                TextStyle(color: Colors.black, fontFamily: _latoBoldFontFamily),
          ),
          onPressed: () {
            context.read<SignupBloc>().add(BackToLoginNavigationEvent(
                isBackToNavigationButtonPressed: true));
          },
        );
      },
    );
  }
}
