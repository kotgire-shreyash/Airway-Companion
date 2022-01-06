import 'package:airwaycompanion/Logic/Bloc/AzureBotBloc/azure_bot_bloc.dart';
import 'package:airwaycompanion/Logic/Bloc/ChecklistBloc/checklist_bloc.dart';
import 'package:airwaycompanion/Logic/Bloc/FlightsScreenBloc/flights_screen_bloc.dart';
import 'package:airwaycompanion/Modules/Routes/screen_router.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Logic/Bloc/AuthenticationBloc/login_bloc.dart';
import 'Logic/Bloc/HomeBloc/home_screen_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  AwesomeNotifications().initialize(
    'resource://drawable/airway_companion',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.brown,
        channelDescription: 'Basic Channel description',
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
    ],
  );
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
    AwesomeNotifications().isNotificationAllowed().then((isallowed) {
      if (!isallowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    // AwesomeNotifications().createdStream.listen((event) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text('Notifcation Created on ${event.channelKey}'),
    //   ));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeScreenBloc()),
        BlocProvider(create: (context) => FlightScreenBloc()),
        BlocProvider(create: (context) => CheckListScreenBloc()),
        BlocProvider(create: (context) => AzureBotBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        onGenerateRoute: _authPageRouter.onGenerateRoute,
        initialRoute: "login",
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
