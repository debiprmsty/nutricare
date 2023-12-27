import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TotalHomeController{
  final dio = Dio();
  final baseUrl = "https://testchairish.000webhostapp.com/api/";

  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<dynamic> fetchTotalHome(String nama_posko) async {
    final token = await _getToken();
    if(token != null) {
      print(nama_posko);
      final url = "$baseUrl" + 'total';
      final response = await dio.get(url, options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),);

      if (response.statusCode == 200) {
          final data = response.data;
          if(data != null) {
            return data;
          }
      } else {
        print('Gagal mengambil data dari API');
      }
    }
  }
}