class User{
  int id;
  String fullname;
  String? email;
  String? password;
  String? no_hp;
  int? code_kabupaten;
  int? code_kecamatan;
  int? code_kelurahan;
  String? nama_dusun;
  String role;
  String image;

  User({
    required this.id,
    required this.fullname,
    this.email,
    this.password,
    this.no_hp,
    this.code_kabupaten,
    this.code_kecamatan,
    this.code_kelurahan,
    this.nama_dusun,
    required this.role,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      password: json['password'],
      no_hp: json['no_hp'],
      code_kabupaten: json['code_kabupaten'],
      code_kecamatan: json['code_kecamatan'],
      code_kelurahan: json['code_kelurahan'],
      nama_dusun: json['nama_dusun'],
      role: json['role'],
      image: json['image'],
    );
  }
}