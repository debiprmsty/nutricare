import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:nutricare/models/Balita.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BalitaController {
  final dio = Dio();
  final baseUrl = "https://testchairish.000webhostapp.com/api/";

   Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }


  Future<dynamic> fetchBalita() async {
    final token = await _getToken();
    if(token != null) {
      final url = "$baseUrl" + 'balita';
      Response response = await dio.get(url,options: Options(
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

  Future<dynamic> fetchBalitaId(String id) async {
    final token = await _getToken();
    if (token != null) {
      final url = "$baseUrl" + 'balita/detail/$id';
      Response response = await dio.get(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null) {

          return data['data'];
        }
      } else {
        print('Gagal mengambil data dari API');
      }
    }

      // Jika terjadi kesalahan atau data tidak tersedia, kembalikan nilai null atau lakukan penanganan kesalahan sesuai kebutuhan aplikasi Anda.
      return null;
    }

  Future<dynamic> addBalita(String nik_balita, String nama,String tanggal_lahir,String umur,String jenis_kelamin,String alamat,String id_kk,String id_ortu, String nama_posko)async {
    final token = await _getToken();
    
    if(token != null) {
      Response response = await dio.post(
        '$baseUrl' + 'balita',
        data: {
          'nama': nama,
          'tanggal_lahir': tanggal_lahir,
          'nik_balita' : nik_balita,
          'nama_dusun' : alamat,
          'id_ortu' : id_ortu,
          'id_kk' : id_kk,
          'jenis_kelamin' : jenis_kelamin,
          'nama_posko' : nama_posko,
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


  Future<dynamic> updateBalita(String nik_balita, String nama,String tanggal_lahir,String umur,String jenis_kelamin,String alamat,String id_kk,String id_ortu,String id_balita,String nama_posko) async {
    final token = await _getToken();
    
    if(token != null) {
      Response response = await dio.post(
        '$baseUrl' + 'balita/$id_balita',
        data: {
          'nama': nama,
          'tanggal_lahir': tanggal_lahir,
          'nik_balita' : nik_balita,
          'nama_dusun' : alamat,
          'id_ortu' : id_ortu,
          'id_kk' : id_kk,
          'jenis_kelamin' : jenis_kelamin,
          'nama_posko' : nama_posko
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

  Future<dynamic> deleteBalita(String id) async {
    final token = await _getToken();
    if(token != null) {
      final url = "$baseUrl" + 'balita/delete/$id';
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