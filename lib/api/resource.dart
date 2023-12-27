import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:nutricare/models/Kabupaten.dart';

class ResourceController {
  final dio = Dio();
  final urlKabupaten = "https://ibnux.github.io/data-indonesia/kabupaten/";
  final urlKecamatan = "https://ibnux.github.io/data-indonesia/kecamatan/";
  final urlKelurahan = "https://ibnux.github.io/data-indonesia/kelurahan/";
 

  Future<dynamic> fetchKabupaten(String code) async {
  
    try {
      Response response = await dio.get(
        urlKabupaten + '51.json',
      );  

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null) {
          return data;
        }
      } else {
        print('Gagal mengambil data dari API');
      }
    } catch (error) {
      print('Error: $error');
      // Tambahkan logika penanganan kesalahan sesuai kebutuhan.
      throw error; // Re-throw error agar dapat ditangkap oleh pemanggil fungsi.
    }

    throw Exception('Gagal mengambil data dari API'); // Tambahkan throw statement di akhir
  }

   Future<dynamic> fetchKecamatan(String code) async {
  
    try {
      Response response = await dio.get(
        urlKecamatan + '$code.json',
      );  

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null) {
          return data;
        }
      } else {
        print('Gagal mengambil data dari API');
      }
    } catch (error) {
      print('Error: $error');
      // Tambahkan logika penanganan kesalahan sesuai kebutuhan.
      throw error; // Re-throw error agar dapat ditangkap oleh pemanggil fungsi.
    }

    throw Exception('Gagal mengambil data dari API'); // Tambahkan throw statement di akhir
  }

   Future<dynamic> fetchKelurahan(String code) async {
  
    try {
      Response response = await dio.get(
        urlKelurahan + '$code.json',
      );  

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null) {
          return data;
        }
      } else {
        print('Gagal mengambil data dari API');
      }
    } catch (error) {
      print('Error: $error');
      // Tambahkan logika penanganan kesalahan sesuai kebutuhan.
      throw error; // Re-throw error agar dapat ditangkap oleh pemanggil fungsi.
    }

    throw Exception('Gagal mengambil data dari API'); // Tambahkan throw statement di akhir
  }

  

}