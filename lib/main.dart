import 'package:airwaycompanion/Modules/Routes/screen_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Logic/Bloc/AuthenticationBloc/login_bloc.dart';
import 'Logic/Bloc/HomeBloc/home_screen_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const AirwayCompanionApp());
}

class AirwayCompanionApp extends StatefulWidget {
  const AirwayCompanionApp({Key? key}) : super(key: key);

  @override
  _AirwayCompanionAppState createState() => _AirwayCompanionAppState();
}

class _AirwayCompanionAppState extends State<AirwayCompanionApp> {
  final GlobalRouter _authPageRouter = GlobalRouter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => HomeScreenBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        onGenerateRoute: _authPageRouter.onGenerateRoute,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
