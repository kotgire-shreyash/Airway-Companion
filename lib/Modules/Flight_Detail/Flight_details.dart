import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Main Function Start

// First Stateless Widget with MaterialApp Ends

// Main Stateful Widget Start
class MapNavigationScreen extends StatefulWidget {
  @override
  _MapNavigationScreenState createState() => _MapNavigationScreenState();
}

class _MapNavigationScreenState extends State<MapNavigationScreen> {
  // Title List Here
  var titleList = [
    "Mumbai to Delhi",
    "Delhi to Mumbai",
    "Chennai to Bangalore",
    "Bangalore to Chennai",
    "Kolkata to Hyderabad",
    "Hyderabad to Kolkata",
    "Jaipur to Mumbai"
  ];

  // Description List Here
  var ic = Icon(Icons.calendar_today);
  var descList = [
    "Date:                  Day: \nArrival:              Departure:",
    "Date:                  Day: \nArrival:              Departure:",
    "Date:                  Day: \nArrival:              Departure:",
    "Date:                  Day: \nArrival:              Departure:",
    "Date:                  Day: \nArrival:              Departure:",
    "Date:                  Day: \nArrival:              Departure:",
    "Date:                  Day: \nArrival:              Departure: "
  ];

  // Image Name List Here
  var imgList = [
    "assets/images/plane1.jpg",
    "assets/images/plane1.jpg",
    "assets/images/plane1.jpg",
    "assets/images/plane1.jpg",
    "assets/images/plane1.jpg",
    "assets/images/plane1.jpg",
    "assets/images/plane1.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    // MediaQuery to get Device Width
    double width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      appBar: AppBar(
        // App Bar
        title: Text(
          "Flight Details",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
      // Main List View With Builder
      body: ListView.builder(
        itemCount: imgList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // This Will Call When User Click On ListView Item
              showDialogFunc(
                  context, imgList[index], titleList[index], descList[index]);
            },
            // Card Which Holds Layout Of ListView Item
            child: Card(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(imgList[index]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          titleList[index],
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: width,
                          child: Text(
                            descList[index],
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[500]),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// This is a block of Model Dialog
showDialogFunc(context, img, title, desc) {
  String source = "IN";
  String full1 = "INDIA";
  String dest = "DXB";
  String full2 = "DUBAI";
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(15),
            height: 400,
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  // child: Image.asset(
                  //   img,
                  //   width: 200,
                  //   height: 200,
                  // ),
                  child: Column(
                    children: [
                      Container(
                        // height: 80,
                        width: 330,
                        alignment: Alignment.topLeft,
                        child: Text(
                          "FLIGHT                    OPERATED BY                   AIRCRAFT              BOOKING NUMBER",
                          style: TextStyle(fontSize: 9, color: Colors.grey),
                        ),
                      ),

                      // SizedBox(height: 10,),
                      Container(
                        width: 330,
                        alignment: Alignment.topLeft,
                        child: Text(
                          "BLUE-\n EXPRESS           BIALAIRWAY                 AIRBUS 344                 FBX425",
                          style:
                              TextStyle(fontSize: 10, color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Text(
                //   title,
                //   style: TextStyle(
                //     fontSize: 20,
                //     color: Colors.black,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),

                // Till
                Container(
                  child: Row(
                    children: [
                      Container(
                          // height: 100,
                          // width: 300,
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          // ignore: unnecessary_string_interpolations
                          child: Column(
                            children: [
                              Text(
                                // ignore: unnecessary_string_interpolations
                                "$source",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    color: Colors.blueAccent),
                              ),
                              // SizedBox(height: 5),
                              Text(
                                // ignore: unnecessary_string_interpolations
                                "$full1",
                                style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.blueAccent),
                              ),
                            ],
                          )),
                      Container(
                          // height: 100,
                          // width: 300,
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          // ignore: unnecessary_string_interpolations
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                // ignore: unnecessary_string_interpolations
                                " -------- ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.blueAccent),
                              ),
                              Icon(
                                Icons.flight_sharp,
                                color: Colors.blueAccent,
                                size: 50,
                              ),
                              // Icon()
                              Text(
                                // ignore: unnecessary_string_interpolations
                                " -------- ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.blueAccent),
                              ),
                            ],
                          )),
                      Container(
                          // height: 100,
                          // width: 300,
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          // ignore: unnecessary_string_interpolations
                          child: Column(
                            children: [
                              Text(
                                // ignore: unnecessary_string_interpolations
                                "$dest",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    color: Colors.blueAccent),
                              ),
                              Text(
                                // ignore: unnecessary_string_interpolations
                                "$full2",
                                style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.blueAccent),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      // Container(
                      //   // height: 200,
                      //   // width: 100,
                      //   alignment: Alignment.topLeft,
                      //   child: Icon(Icons.dark_mode,color: Colors.blueAccent, size: 50,),
                      // )
                      Icon(
                        Icons.dark_mode,
                        color: Colors.blueAccent,
                        size: 50,
                      ),
                      SizedBox(
                        width: 190,
                      ),
                      Icon(
                        Icons.light_mode,
                        color: Colors.blueAccent,
                        size: 50,
                      ),
                    ],
                  ),
                ),

                Container(
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Container(
                        child: Text(
                          "Sun 22 2021",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                      ),
                      Container(
                        child: Text(
                          "Mon 23 2021",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  child: Row(
                    children: [
                      Container(
                          // height: 100,
                          // width: 300,
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          // ignore: unnecessary_string_interpolations
                          child: Column(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                // ignore: unnecessary_string_interpolations
                                "22:05",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.blueAccent),
                              ),
                              // SizedBox(height: 5),
                              Text(
                                // ignore: unnecessary_string_interpolations
                                "BIARAIRWAY",
                                style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.blueAccent),
                              ),
                            ],
                          )),
                      Container(
                          // height: 100,
                          // width: 300,
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          // ignore: unnecessary_string_interpolations
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                // ignore: unnecessary_string_interpolations
                                " ----- ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.blueAccent),
                              ),
                              Text(
                                // ignore: unnecessary_string_interpolations
                                "15h 40m \n NON STOP",
                                style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    // fontSize: 20,
                                    color: Colors.blueAccent),
                              ),
                              // Icon()
                              Text(
                                // ignore: unnecessary_string_interpolations
                                " ----- ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.blueAccent),
                              ),
                            ],
                          )),
                      Container(
                          // height: 100,
                          // width: 300,
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          // ignore: unnecessary_string_interpolations
                          child: Column(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                // ignore: unnecessary_string_interpolations
                                "08:25",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.blueAccent),
                              ),
                              Text(
                                // ignore: unnecessary_string_interpolations
                                "DUBAI AIRPORT",
                                style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.blueAccent),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),

                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomCenter,
                  color: Colors.blueAccent,
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      // ignore: avoid_unnecessary_containers
                      Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "PASSENGER        SEAT         DEPARTURE     BORDING ZONE      GATE",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "HARRY     334C    22:05 PM         D3        A33",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),

                      // SizedBox(width:10),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
