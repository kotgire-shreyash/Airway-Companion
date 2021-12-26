import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlightsCheckNotifierButton extends StatelessWidget {
  const FlightsCheckNotifierButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        "Check",
        style: TextStyle(
            color: Colors.white,
            fontFamily:
                GoogleFonts.lato(fontWeight: FontWeight.w900).fontFamily),
      ),
      style: TextButton.styleFrom(
        minimumSize: const Size(150, 40),
        primary: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        backgroundColor: Colors.blue.shade600,
        // shape: const StadiumBorder(),
      ),
      onPressed: () {
        Navigator.pushNamed(context, "availableFlights");
      },
    );
  }
}
