import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class AuthController {
  final dio = Dio();
  final baseUrl = "https://testchairish.000webhostapp.com/api/";

  Future<dynamic> register(String fullname, String email, String password, String no_hp, String role,String code_kabupaten, String code_kecamatan, String code_kelurahan, String nama_dusun) async {
    Response response = await dio.post(
        '$baseUrl' + 'register',
        data: {
          'fullname' : fullname,
          'no_hp' : no_hp,
          'email': email,
          'password': password,
          'role':role,
          'code_kabupaten' : code_kabupaten,
          'code_kecamatan' : code_kecamatan,
          'code_kelurahan' : code_kelurahan,
          'nama_dusun' : nama_dusun
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) { return status! < 500; },
          headers: {
            "Accept" : "application/json",
            },
        ),
      );

      print(response.data); // Tambahkan baris ini untuk melihat respons
      print(response.statusCode);

      if (response.statusCode == 201) {
        return response.data;
      } else {
        print(response.data);
      }

  }

  Future<dynamic> login(String email, String password) async {
    Response response = await dio.post(
        '$baseUrl' + 'login',
        data: {
          'email': email,
          'password': password,
        },
      );

      print(response.data); // Tambahkan baris ini untuk melihat respons
      print(response.statusCode);

      if (response.statusCode == 200) {
        return response.data;
      } 

  }
}