import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationButton extends StatelessWidget {
  const VerificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        "Verify",
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
        backgroundColor: Colors.blue.shade700,
        // shape: const StadiumBorder(),
      ),
      onPressed: () {},
    );
  }
}
