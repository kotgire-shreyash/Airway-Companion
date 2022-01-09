import 'package:http/http.dart' as http;

// Flight API Source
class FlightAPI {
  final accessKey =
      "e470acc817ea59fecc18f59e7003100f"; // Alternate Key : 96ff231edea6f72576f01eb9c5454263

  Future<http.Response> getFlightDataEncoded() async {
    try {
      var response = await http.get(
        Uri.http(
            "api.aviationstack.com", 'v1/flights', {'access_key': accessKey}),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
