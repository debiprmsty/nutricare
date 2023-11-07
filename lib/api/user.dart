import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController{
  final dio = Dio();
  final baseUrl = "https://testchairish.000webhostapp.com/api/";

  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<dynamic> fetchUser() async {
    final token = await _getToken();
    if(token != null) {
      final url = "$baseUrl" + 'me';
      Response response = await dio.get(url,options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),);

      if (response.statusCode == 200) {
        final data = response.data;
        return data;
      } else {
        print('Gagal mengambil data dari API');
      }
    }
  }

  Future<dynamic> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = await _getToken();
    if(token != null) {
      final url = "$baseUrl" + "logout";
      Response response = await dio.get(url,options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),);

      if (response.statusCode == 200) {
          final data = response.data;
          print(data);

          prefs.remove('token');
        
      }else {
        print('Gagal mengambil data dari API');
      }
    }
  }

}