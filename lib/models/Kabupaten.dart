class KabupatenModel {
  final String id;
  final String nama;

  KabupatenModel({
    required this.id,
    required this.nama
  });
  
  factory KabupatenModel.fromJson(Map<String, dynamic> json) {
    return KabupatenModel(
      id: json['id'],
      nama: json['nama']
    );
  }

  static List<KabupatenModel> fromJsonList(List list) {
    return list.map((item) => KabupatenModel.fromJson(item)).toList();
  }
}
