import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/models/Restaurant.dart';
import 'package:tawelticlient/models/event.dart';

class RestaurantServices{

  static const API = 'http://10.0.2.2:3000/';

  Future<APIResponse<List<Restaurant>>> getRestaurantsList() {
    return http
        .get(
      Uri.parse(API + 'restaurants'),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final floors = <Restaurant>[];
        for (var item in jsonData) {
          floors.add(Restaurant.fromJson(item));
        }
        return APIResponse<List<Restaurant>>(data: floors);
      }
      return APIResponse<List<Restaurant>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Restaurant>>(
        error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<List<Event>>> getRestaurantsListEvents(String restaurantId) {
    return http
        .get(
      Uri.parse(API + 'restaurants/evenement/'+ restaurantId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <Event>[];
        for (var item in jsonData) {
          events.add(Event.fromJson(item));
        }
        return APIResponse<List<Event>>(data: events);
      }
      return APIResponse<List<Event>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Event>>(
        error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> createRestaurant(Restaurant item) {
    return http
        .post(Uri.parse(API + 'restaurant/AddRestaurant'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<Restaurant>> getRestaurant(String restaurantId) {
    return http
        .get(
      Uri.parse(API + 'restaurants/' + restaurantId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Restaurant>(data: Restaurant.fromJson(jsonData));
      }
      return APIResponse<Restaurant>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<Restaurant>(error: true, errorMessage: 'An error occured'));
  }


  Future<APIResponse<Restaurant>> getRestaurantcuisine(String restaurantId) {

    return http
        .get(
      Uri.parse(API + 'restaurants/cuisine' + restaurantId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
      return APIResponse<Restaurant>(data: Restaurant.fromJson(jsonData));
      }
      return APIResponse<Restaurant>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<Restaurant>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> updateRestaurant(String restoID, Restaurant item) {
    return http.put(Uri.parse(API + 'restaurant/UpdateRestaurant/' + restoID),  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(item)).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> deleteRestaurant(String restaurantID) {
    return http.delete(Uri.parse(API + 'restaurants/' + restaurantID), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'}).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

}
