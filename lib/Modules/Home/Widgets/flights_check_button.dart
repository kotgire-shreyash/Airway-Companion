import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlightsCheckNotifierButton extends StatelessWidget {
  const FlightsCheckNotifierButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Container(
        height: 35,
        width: 130,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          color: Colors.white,
        ),
        child: ElevatedButton(
          child: Text(
            "Check",
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily:
                    GoogleFonts.lato(fontWeight: FontWeight.w900).fontFamily),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 5,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "availableFlights");
          },
        ),
      ),
    );
  }
}
