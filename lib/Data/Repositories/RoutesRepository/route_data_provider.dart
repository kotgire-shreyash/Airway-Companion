import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

// Navigation Routes
class Routes {
  var origin;
  var destination;
  final points = <LatLng>[];
  Routes({this.origin, this.destination});
  Future<List<LatLng>> getRouteDetails() async {
    try {
      var url = Uri.parse(
          'https://atlas.microsoft.com/route/directions/json?subscription-key=OmHax9byGsCpudWRxU0lYnTgw81r6Eq9nlCqRk3EnGI&api-version=1.0&query=${origin.latitude},${origin.longitude}:${destination.latitude},${destination.longitude}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var responsedata = json.decode(response.body);
        for (var item in responsedata['routes'][0]['legs'][0]['points']) {
          points.add(LatLng(item['latitude'], item['longitude']));
        }
      }

      return points;
    } catch (e) {
      rethrow;
    }
  }
}
