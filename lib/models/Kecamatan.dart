class KecamatanModel {
  final String id;
  final String nama;

  KecamatanModel({
    required this.id,
    required this.nama
  });
  
  factory KecamatanModel.fromJson(Map<String, dynamic> json) {
    return KecamatanModel(
      id: json['id'],
      nama: json['nama']
    );
  }

  static List<KecamatanModel> fromJsonList(List list) {
    return list.map((item) => KecamatanModel.fromJson(item)).toList();
  }
}
