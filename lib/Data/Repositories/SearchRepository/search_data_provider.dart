import 'dart:convert';
import 'package:airwaycompanion/Data/Repositories/SearchRepository/search_model.dart';
import 'package:http/http.dart' as http;

// Search Amenities
class Search {
  List<SearchModel> searchResultList = [];
  Future<List<SearchModel>> searchNearby(
      {required String searchdata,
      double lat = 13.199165,
      double long = 77.707984}) async {
    try {
      var url = Uri.parse(
          "https://atlas.microsoft.com/search/poi/category/json?subscription-key=OmHax9byGsCpudWRxU0lYnTgw81r6Eq9nlCqRk3EnGI&api-version=1.0&query=${searchdata}&lat=${lat}&lon=${long}&limit=10&radius=4000");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var responsedata = json.decode(response.body);
        for (var item in responsedata['results']) {
          searchResultList.add(SearchModel(
            name: item['poi']['name'],
            address: item['address']['freeformAddress'],
            distance: item['dist'],
            latitude: item['position']['lat'],
            longitude: item['position']['lon'],
          ));
        }
      }
      return searchResultList;
    } catch (e) {
      rethrow;
    }
  }
}
