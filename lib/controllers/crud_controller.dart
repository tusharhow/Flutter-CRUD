import 'dart:convert';

import 'package:crypto_fate/models/crypto_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserController extends ChangeNotifier {
  static const url = "http://10.0.2.2:8080/users";
  var data = [];
  Future<List<UserModel>> getUsers() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return data = jsonResponse
          .map<UserModel>((json) => UserModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

// add user to database
  Future<UserModel> addUser(UserModel user) async {
    const creaye = "http://10.0.2.2:8080/createUser";
    final response = await http.post(Uri.parse(creaye),
        headers: {"Content-Type": "application/json"},
        body: json.encode(user.toJson()));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return UserModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // delete user from database
  Future deleteUser(String id) async {
    var delete = "http://10.0.2.2:8080/deleteUser/${id}";
    final response = await http.delete(Uri.parse(delete));

    if (response.statusCode == 200) {
      print("deleted");
    } else {
      throw Exception('Failed to load data');
    }
  }
}
