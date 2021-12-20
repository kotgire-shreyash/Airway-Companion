import 'package:http/http.dart' as http;

class FlightAPI {
  final _accessKey = "738cde56fe083ab79cf14188df151175";
  Future<http.Response> getFlightDataEncoded() async {
    try {
      var response = await http.get(Uri.https(
          "api.aviationstack.com", 'v1/flights?access_key=$_accessKey'));
      return response;
    } catch (e) {
      // return http.Response("Null", 0);
      print("$e FAILED");
      rethrow;
    }
  }
}
