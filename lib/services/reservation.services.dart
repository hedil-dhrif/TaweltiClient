import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/models/reservation.dart';


class ReservationServices {
  Client client = Client();

  static const API = 'http://37.187.198.241:3000/';

  Future<APIResponse<List<Reservation>>> getReservationsList() {
    return client
        .get(
      Uri.parse(API + 'reservations'),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final floors = <Reservation>[];
        for (var item in jsonData) {
          floors.add(Reservation.fromJson(item));
        }
        return APIResponse<List<Reservation>>(data: floors);
      }
      return APIResponse<List<Reservation>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<List<Reservation>>(
            error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<List<Reservation>>> getUsersListReservations(String userId) {
    return client
        .get(
      Uri.parse(API + 'users/reservation/'+ userId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <Reservation>[];
        for (var item in jsonData) {
          events.add(Reservation.fromJson(item));
        }
        return APIResponse<List<Reservation>>(data: events);
      }
      return APIResponse<List<Reservation>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Reservation>>(
        error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<Reservation>> getReservation(String reservationId) {
    return client
        .get(
      Uri.parse(API + 'reservations/' + reservationId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Reservation>(data: Reservation.fromJson(jsonData));
      }
      return APIResponse<Reservation>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<Reservation>(error: true, errorMessage: 'An error occured'));
  }
  Future createReservation(item) async {
    final response =
    await client.post(Uri.parse(API + 'reservations/create'),headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'},body: jsonEncode(item.toJson()));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('exception occured!!!!!!');
    }
  }

  Future<APIResponse<bool>> updateReservation(String reservationID, Reservation item) {
    return client.put(Uri.parse(API + 'reservations/' + reservationID),  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> deleteReservation(String reservationID) {
    return client.delete(Uri.parse(API + 'reservations/' + reservationID), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'}).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
  // Future getReservation(client) async {
  //   final response =
  //   await client.get(Uri.parse(API + 'reservations/1'));
  //
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('exception occured!!!!!!');
  //   }
  // }
}