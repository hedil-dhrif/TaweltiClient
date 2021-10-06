import 'dart:convert';

import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/models/ambiance.dart';
import 'package:http/http.dart' show Client;

class AmbianceServices{
  Client client = Client();

  static const API = 'http://10.0.2.2:3000/';


  Future<APIResponse<List<Ambiance>>> getListAmbiance() {
    return client
        .get(
      Uri.parse(API + 'ambiances'),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <Ambiance>[];
        for (var item in jsonData) {
          events.add(Ambiance.fromJson(item));
        }
        return APIResponse<List<Ambiance>>(data: events);
      }
      return APIResponse<List<Ambiance>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Ambiance>>(
        error: true, errorMessage: 'An error occured'));
  }
  Future<APIResponse<List<Ambiance>>> getRestaurantsListAmbiance(
      String restaurantId) {
    return client
        .get(
      Uri.parse(API + 'restaurants/ambiance/' + restaurantId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <Ambiance>[];
        for (var item in jsonData) {
          events.add(Ambiance.fromJson(item));
        }
        return APIResponse<List<Ambiance>>(data: events);
      }
      return APIResponse<List<Ambiance>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Ambiance>>(
        error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> addAmbiance(Ambiance item) {
    return client
        .post(Uri.parse(API + 'ambiances/create'),
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

  Future<APIResponse<bool>> updateAmbiance(String ID, Ambiance item) {
    return client.put(Uri.parse(API + 'ambiances/' + ID),  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> deleteAmbiance(String ID) {
    return client.delete(Uri.parse(API + 'ambiances/' + ID), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'}).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}