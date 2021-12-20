import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:airwaycompanion/Modules/General Widgets/Bottom Navigation Bar/bottom_navigation_bar.dart'
    as bottomBar;
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AvailableFlights extends StatefulWidget {
  const AvailableFlights({Key? key}) : super(key: key);

  @override
  _AvailableFlightsState createState() => _AvailableFlightsState();
}

class _AvailableFlightsState extends State<AvailableFlights> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepPurpleAccent.shade200,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.6,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent.shade200,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Search Flights",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily:
                            GoogleFonts.lato(fontWeight: FontWeight.w900)
                                .fontFamily,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      height: MediaQuery.of(context).size.height / 3.5,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "source",
                                icon: Icon(
                                  FontAwesomeIcons.sourcetree,
                                  color: Colors.grey.shade600,
                                  size: 22,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "destination",
                                icon: Icon(
                                  CupertinoIcons.airplane,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Search",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold)
                                        .fontFamily,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Colors.deepPurpleAccent.shade200,
                                  minimumSize: const Size(130, 40),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: ListView.builder(
                itemCount: 20,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, int index) {
                  return Card(
                    elevation: 10,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Container(
                      height: 200,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
