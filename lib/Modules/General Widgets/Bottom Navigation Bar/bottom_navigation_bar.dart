import 'package:airwaycompanion/Logic/Bloc/FlightsScreenBloc/flights_screen_bloc.dart';
import 'package:airwaycompanion/Modules/ChatBot/Widget/chat_bot.dart';
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavigationBar extends StatefulWidget {
  const BottomNavigationBar({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarState createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomBarWithSheet(
      sheetChild: const Center(child: Text("Content")),
      selectedIndex: 1,
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
          Navigator.pushNamed(context, 'availableFlights');
        }
        if (index == 2) {
          Navigator.pushNamed(context, 'timeline');
        }
      },
    );
  }

  final List<BottomBarWithSheetItem> _items = [
    const BottomBarWithSheetItem(
        icon: Icons.airplanemode_active_outlined, label: "Flights"),
    const BottomBarWithSheetItem(icon: CupertinoIcons.home, label: "Home"),
    const BottomBarWithSheetItem(
        icon: CupertinoIcons.settings, label: "Settings"),
  ];
}
