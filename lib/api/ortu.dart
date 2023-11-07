import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:nutricare/models/OrangTua.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrtuController {
  final dio = Dio();
  final baseUrl = "https://testchairish.000webhostapp.com/api/";

   Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }


  Future<dynamic> fetchOrtu() async {
    final token = await _getToken();
      if(token != null) {
        final url = "$baseUrl" + 'ortu';
        Response response = await dio.get(url, options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),);

        if (response.statusCode == 200) {
            final data = response.data;
            if(data != null) {
              print(data['data']);
              return data['data'];
            }
        } else {
          print('Gagal mengambil data dari API');
        }
      }
    }

    Future<OrangTua?> fetchOrtuId(String id) async {
    final token = await _getToken();
    if (token != null) {
      final url = "$baseUrl" + 'ortu/search/${id}';
      Response response = await dio.get(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null) {
          print(data['data']);

          // Membuat objek OrangTua dari data JSON
          OrangTua orangTua = OrangTua.fromJson(data['data']);

          // Mengembalikan objek OrangTua
          return orangTua;
        }
      } else {
        print('Gagal mengambil data dari API');
      }
    }

      // Jika terjadi kesalahan atau data tidak tersedia, kembalikan nilai null atau lakukan penanganan kesalahan sesuai kebutuhan aplikasi Anda.
      return null;
    }



  Future<dynamic> addOrtu(String nik_keluarga, String nik_bapak, String nik_ibu, String nama_bapak, String nama_ibu, String alamat) async {
    final token = await _getToken();
    
    if(token != null) {
      Response response = await dio.post(
        '$baseUrl' + 'ortu',
        data: {
          'alamat' : alamat,
          'nama_ibu' : nama_ibu,
          'nama_bapak' : nama_bapak,
          'nik_keluarga' : nik_keluarga,
          'nik_bapak' : nik_bapak,
          'nik_ibu' : nik_ibu,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        )
      );


      if (response.statusCode == 201) {
        return response.data;
      } 
    }

  }

  Future<dynamic> upateOrtu(String id, String id_kk, String nik_keluarga, String nik_bapak, String nik_ibu, String nama_bapak, String nama_ibu, String alamat) async {
    final token = await _getToken();
    
    if(token != null) {
      Response response = await dio.post(
        '$baseUrl' + 'ortu/$id',
        data: {
          'alamat' : alamat,
          'nama_ibu' : nama_ibu,
          'nama_bapak' : nama_bapak,
          'id_kk' : id_kk,
          'nik_kk' : nik_keluarga,
          'nik_bapak' : nik_bapak,
          'nik_ibu' : nik_ibu,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        )
      );


      if (response.statusCode == 200) {
        return response.data;
      } 
    }

  }

  Future<dynamic> deleteOrtu(String id) async {
    final token = await _getToken();
      if(token != null) {
        final url = "$baseUrl" + 'ortu/delete/$id';
        Response response = await dio.get(url, options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),);

        if (response.statusCode == 200) {
            final data = response.data;
            if(data != null) {
              print(data['data']);
              return data['data'];
            }
        } else {
          print('Gagal mengambil data dari API');
        }
      }
    }

}