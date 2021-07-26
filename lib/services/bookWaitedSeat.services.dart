import 'dart:convert';

import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/models/bookWaitSeat.dart';
import 'package:http/http.dart' show Client;


class BookWaitSeatServices{
  Client client = Client();

  static const API = 'http://10.0.2.2:3000/';

  Future<APIResponse<List<BookWaitSeat>>> getRestaurantsListBWS(
      String restaurantId) {
    return client
        .get(
      Uri.parse(API + 'BWS/GetALlBookWaitSeat/' + restaurantId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <BookWaitSeat>[];
        for (var item in jsonData) {
          events.add(BookWaitSeat.fromJson(item));
        }
        return APIResponse<List<BookWaitSeat>>(data: events);
      }
      return APIResponse<List<BookWaitSeat>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<BookWaitSeat>>(
        error: true, errorMessage: 'An error occured'));
  }

}