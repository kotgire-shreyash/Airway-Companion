import 'package:airwaycompanion/Modules/Home/Widgets/chat_bot.dart';
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget bottomNavigationBar() {
  return BottomBarWithSheet(
    sheetChild: const Center(child: Text("Content")),
    // mainActionButton: ChatBot(),
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
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
    ),
    items: _items,
  );
}

List<BottomBarWithSheetItem> _items = [
  const BottomBarWithSheetItem(
      icon: Icons.airplanemode_active_outlined, label: "Bookings"),
  const BottomBarWithSheetItem(icon: CupertinoIcons.home, label: "Home"),
  const BottomBarWithSheetItem(
      icon: CupertinoIcons.settings, label: "Settings"),
];