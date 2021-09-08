import 'dart:convert';

import 'package:tawelticlient/api/api_Response.dart';
import 'package:http/http.dart' show Client;
import 'package:tawelticlient/models/file.dart';
import 'package:tawelticlient/models/fileEvent.dart';

class FileEventServices{
  Client client = Client();

  static const API = 'http://10.0.2.2:3000/';


  Future<APIResponse<List<FileEvent>>> getListAmbiance(String eventId) {
    return client
        .get(
      Uri.parse(API + 'fileEvent/info/'+eventId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <FileEvent>[];
        for (var item in jsonData) {
          events.add(FileEvent.fromJson(item));
        }
        return APIResponse<List<FileEvent>>(data: events);
      }
      return APIResponse<List<FileEvent>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<FileEvent>>(
        error: true, errorMessage: 'An error occured'));
  }
  // Future<APIResponse<List<File>>> getRestaurantsListAmbiance(
  //     String restaurantId) {
  //   return client
  //       .get(
  //     Uri.parse(API + 'restaurants/ambiance/' + restaurantId),
  //   )
  //       .then((data) {
  //     if (data.statusCode == 200) {
  //       final jsonData = json.decode(data.body);
  //       final events = <Ambiance>[];
  //       for (var item in jsonData) {
  //         events.add(Ambiance.fromJson(item));
  //       }
  //       return APIResponse<List<Ambiance>>(data: events);
  //     }
  //     return APIResponse<List<Ambiance>>(
  //         error: true, errorMessage: 'An error occured');
  //   }).catchError((_) => APIResponse<List<Ambiance>>(
  //       error: true, errorMessage: 'An error occured'));
  // }


}