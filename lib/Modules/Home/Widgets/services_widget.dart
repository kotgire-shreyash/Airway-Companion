import 'package:flutter/material.dart';

class ServicesWidget extends StatelessWidget {
  ServicesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: _servicesList.length,
        itemBuilder: (context, int index) {
          return Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: Colors.grey.shade600)),
                      child: Center(
                        child: Icon(
                          _servicesList[index][0],
                          size: 40,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    child: Text(_servicesList[index][1]),
                  ),
                ],
              ),
              const SizedBox(width: 25)
            ],
          );
        },
      ),
    );
  }

  final List _servicesList = [
    [Icons.local_parking_outlined, "Parking"],
    [Icons.hotel, "Lounges"],
    [Icons.leave_bags_at_home_outlined, "Luggage"],
    [Icons.travel_explore_outlined, "Explore"],
  ];
}
