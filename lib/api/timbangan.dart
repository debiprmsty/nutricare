import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:nutricare/models/Timbangan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimbanganController{
  final dio = Dio();
  final baseUrl = "https://testchairish.000webhostapp.com/api/";

  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<dynamic> fetchTimbangan() async {
    final token = await _getToken();
    if(token != null) {
      final url = "$baseUrl" + 'penimbangan';
      Response response = await dio.get(url, options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),);

      if (response.statusCode == 200) {
          final data = response.data;
          if(data != null) {
            return data['data'];
          }
      } else {
        print('Gagal mengambil data dari API');
      }
    }
  }

  Future<dynamic> fetchTimbanganId(String id) async {
    final token = await _getToken();
    if (token != null) {
      final url = "$baseUrl" + 'penimbangan/search/$id';
      Response response = await dio.get(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        if (data != null) {

          return data;
        }
      } else {
        print('Gagal mengambil data dari API');
      }
    }

      // Jika terjadi kesalahan atau data tidak tersedia, kembalikan nilai null atau lakukan penanganan kesalahan sesuai kebutuhan aplikasi Anda.
      return null;
    }



  Future<dynamic> addTimbangan(String id_balita, String tanggal_timbangan, String berat_badan, String tinggi_badan,String nama_posko) async {
    final token = await _getToken();
    
    if(token != null) {
      Response response = await dio.post(
        '$baseUrl' + 'penimbangan',
        data: {
          'id_balita' : id_balita,
          'tanggal_timbangan' : tanggal_timbangan,
          'berat_badan' : berat_badan,
          'tinggi_badan' : tinggi_badan,
          "nama_posko" : nama_posko,
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

  Future<dynamic> updateTimbangan(String id, String id_balita, String tanggal_timbangan, String berat_badan, String tinggi_badan,String nama_posko) async {
    final token = await _getToken();
    
    if(token != null) {
      Response response = await dio.post(
        '$baseUrl' + 'penimbangan/$id',
        data: {
          'id_balita' : id_balita,
          'tanggal_timbangan' : tanggal_timbangan,
          'berat_badan' : berat_badan,
          'tinggi_badan' : tinggi_badan,
          'nama_posko' : nama_posko,
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

  Future<dynamic> deleteTimbangan(String id) async {
    final token = await _getToken();
    if(token != null) {
      final url = "$baseUrl" + 'penimbangan/delete/$id';
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