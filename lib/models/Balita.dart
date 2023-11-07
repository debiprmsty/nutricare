class Balita {
  int id;
  dynamic nik_balita;
  String nama;
  String tanggal_lahir;
  String umur;
  String jenis_kelamin;
  String nama_dusun;
  Map keluarga;
  Map ortu;

  Balita({required this.id, required this.nik_balita, required this.nama, required this.tanggal_lahir, required this.umur,required this.jenis_kelamin, required this.nama_dusun, required this.keluarga, required this.ortu});


  factory Balita.fromJson(Map<String, dynamic> json) {
    return Balita(
      id: json['id'],
      nik_balita: json['nik_balita'],
      nama: json['nama'],
      tanggal_lahir: json['tanggal_lahir'],
      umur: json['umur'],
      jenis_kelamin: json['jenis_kelamin'],
      nama_dusun: json['nama_dusun'],
      keluarga: json['keluarga'],
      ortu: json['ortu'],
    );
  }

}