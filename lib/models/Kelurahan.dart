class KelurahanModel {
  final String id;
  final String nama;

  KelurahanModel({
    required this.id,
    required this.nama
  });
  
  factory KelurahanModel.fromJson(Map<String, dynamic> json) {
    return KelurahanModel(
      id: json['id'],
      nama: json['nama']
    );
  }

  static List<KelurahanModel> fromJsonList(List list) {
    return list.map((item) => KelurahanModel.fromJson(item)).toList();
  }
}
