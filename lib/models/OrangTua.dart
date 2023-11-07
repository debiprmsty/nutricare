class OrangTua {
    int id;
    int id_kk;
    int nik_bapak;
    int nik_ibu;
    int nik_keluarga;
    String nama_bapak;
    String nama_ibu;
    String alamat;
    Map keluarga;

    OrangTua({required this.id, required this.id_kk, required this.nik_bapak, required this.nama_bapak,required this.alamat,required this.nama_ibu,required this.nik_ibu, required this.nik_keluarga,required this.keluarga});

    factory OrangTua.fromJson(Map<String, dynamic> json) {
      return OrangTua(
        id: json['id'] ?? 0, 
        id_kk: json['id_kk'],// Nilai default jika null
        nik_bapak: json['nik_bapak'] ?? 0, // Nilai default jika null
        nama_bapak: json['nama_bapak'] ?? "",
        nik_keluarga: json['nik_keluarga'] ?? 0, // Nilai default jika null
        alamat: json['alamat'] ?? "",
        nama_ibu: json['nama_ibu'] ?? "",
        nik_ibu: json['nik_ibu'] ?? 0,
        keluarga: json['keluarga'] // Nilai default jika null
      );
    }

}