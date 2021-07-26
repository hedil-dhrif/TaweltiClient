import 'dart:convert';

import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/models/etablissement.dart';
import 'package:http/http.dart' show Client;

class EtablissementServices{
  Client client = Client();

  static const API = 'http://10.0.2.2:3000/';
  Future<APIResponse<List<Etablissement>>> getListEtablissement(){
    return client
        .get(
      Uri.parse(API + 'etablissements'),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <Etablissement>[];
        for (var item in jsonData) {
          events.add(Etablissement.fromJson(item));
        }
        return APIResponse<List<Etablissement>>(data: events);
      }
      return APIResponse<List<Etablissement>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Etablissement>>(
        error: true, errorMessage: 'An error occured'));
  }
  Future<APIResponse<List<Etablissement>>> getRestaurantsListEtablissement(
      String restaurantId) {
    return client
        .get(
      Uri.parse(API + 'restaurants/etablissement/' + restaurantId),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <Etablissement>[];
        for (var item in jsonData) {
          events.add(Etablissement.fromJson(item));
        }
        return APIResponse<List<Etablissement>>(data: events);
      }
      return APIResponse<List<Etablissement>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Etablissement>>(
        error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> addEtablissement(Etablissement item) {
    return client
        .post(Uri.parse(API + 'etablissements/create'),
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

  Future<APIResponse<bool>> updateEtablissement(String ID, Etablissement item) {
    return client.put(Uri.parse(API + 'etablissements/' + ID),  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> deleteEtablissement(String ID) {
    return client.delete(Uri.parse(API + 'etablissements/' + ID), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'}).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}