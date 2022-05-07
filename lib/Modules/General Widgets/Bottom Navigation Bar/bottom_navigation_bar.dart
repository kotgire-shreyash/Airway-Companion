import 'package:airwaycompanion/Logic/Bloc/FlightsScreenBloc/flights_screen_bloc.dart';

import 'package:airwaycompanion/Modules/ChatBot/Widget/chat_bot.dart';
import 'package:airwaycompanion/Modules/Notifications/notifications.dart';
import 'package:airwaycompanion/Modules/Profile/Screens/profile_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);
  static int index = 0;
  static int prevIndex = -1;

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomBarWithSheet(
      sheetChild: const Center(child: Text("Content")),
      selectedIndex: CustomBottomNavigationBar.index,
      disableMainActionButton: true,
      bottomBarTheme: BottomBarTheme(
        contentPadding: const EdgeInsets.only(top: 15),
        height: 50,
        selectedItemIconColor: Colors.blue.shade700,
        itemTextStyle:
            TextStyle(fontFamily: GoogleFonts.lato().fontFamily, fontSize: 10),
        selectedItemTextStyle: TextStyle(
          fontFamily: GoogleFonts.lato(fontWeight: FontWeight.bold).fontFamily,
          color: Colors.blue.shade700,
          fontSize: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(30),
          ),
          border: Border.all(color: Colors.grey.shade100),
        ),
      ),
      items: _items,
      onSelectItem: (index) {
        // Available flights
        if (index == 0) {
          if (CustomBottomNavigationBar.index != index) {
            CustomBottomNavigationBar.index = index;
            Navigator.pushNamed(context, 'home');
          }

          // Home Screen
        } else if (index == 1) {
          if (CustomBottomNavigationBar.index != index) {
            CustomBottomNavigationBar.index = index;
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const FlightDetailsCard()));
            Navigator.pushNamed(context, "availableFlights");
          }
        } else if (index == 2) {
          if (CustomBottomNavigationBar.index != index) {
            CustomBottomNavigationBar.index = index;
            Navigator.pushNamed(context, 'navigation');
          }
        } else if (index == 3) {
          if (CustomBottomNavigationBar.index != index) {
            CustomBottomNavigationBar.index = index;
            Navigator.pushNamed(context, 'guidelines');
          }
        } else if (index == 4) {
          if (CustomBottomNavigationBar.index != index) {
            CustomBottomNavigationBar.index = index;
            Navigator.pushNamed(context, 'bookings');
          }
        }
      },
    );
  }

  final List<BottomBarWithSheetItem> _items = [
    const BottomBarWithSheetItem(icon: CupertinoIcons.home, label: "Home"),
    const BottomBarWithSheetItem(
        icon: Icons.airplanemode_active_outlined, label: "Flights"),
    const BottomBarWithSheetItem(icon: CupertinoIcons.map, label: "Navigation"),
    const BottomBarWithSheetItem(
        icon: CupertinoIcons.book, label: "Guidelines"),
    const BottomBarWithSheetItem(
        icon: CupertinoIcons.list_bullet, label: "Bookings"),
  ];
}
