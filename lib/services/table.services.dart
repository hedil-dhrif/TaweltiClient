import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/models/table.dart';
import 'package:http/http.dart' as http;


class RestaurantTableServices{


  static const API = 'http://10.0.2.2:3000/';


  Future <APIResponse<List<RestaurantTable>>> getRestaurantsListTables(String restaurantId) async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:3000/user/RestaurantWithTable/'+restaurantId));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final jsonData = json.decode(response.body);
      final events = <RestaurantTable>[];
      for (var item in jsonData) {
        events.add(RestaurantTable.fromJson(item));
      }
      return APIResponse<List<RestaurantTable>>(data: events);
     // return RestaurantTable.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}