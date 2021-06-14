import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/models/event.dart';

class EventServices{
  Client client = Client();

  static const API = 'http://10.0.2.2:3000/';

  Future<APIResponse<List<Event>>> getEventsList() {
    return client
        .get(
      Uri.parse(API + 'evenements'),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final floors = <Event>[];
        for (var item in jsonData) {
          floors.add(Event.fromJson(item));
        }
        return APIResponse<List<Event>>(data: floors);
      }
      return APIResponse<List<Event>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Event>>(
        error: true, errorMessage: 'An error occured'));
  }


  Future<APIResponse<Event>> getEvent(String eventId) {
    return client
        .get(
      Uri.parse(API + 'evenements/' + eventId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Event>(data: Event.fromJson(jsonData));
      }
      return APIResponse<Event>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<Event>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> createEvent(Event item) {
    return client
        .post(Uri.parse(API + 'evenements/create'),
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

  Future<APIResponse<bool>> updateEvent(String waiterID, Event item) {
    return client.put(Uri.parse(API + 'evenements/' + waiterID),  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> deleteEvent(String eventID) {
    return client.delete(Uri.parse(API + 'evenements/' + eventID), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'}).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}