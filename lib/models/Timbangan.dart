class Timbangan {
    int id;
    double berat_badan;
    double tinggi_badan;
    String tanggal_timbangan;
    Map balita;
    Map keterangan;
    Map bbu;
    Map tbu;
    Map bbtb;
    Map mtu;

    Timbangan({
      required this.id,
      required this.berat_badan,
      required this.tinggi_badan,
      required this.tanggal_timbangan,
      required this.balita,
      required this.keterangan,
      required this.bbu,
      required this.tbu,
      required this.bbtb,
      required this.mtu,
    });

  factory Timbangan.fromJson(Map<String, dynamic> json) {
    return Timbangan(
      id: json['id'],
      berat_badan: json['berat_badan'],
      tinggi_badan: json['tinggi_badan'],
      tanggal_timbangan: json['tanggal_timbangan'],
      balita: json['balita'],
      keterangan: json['keterangan'],
      bbu: json['bbu'],
      tbu: json['tbu'],
      bbtb: json['bbtb'],
      mtu: json['mtu']
    );
  }

}
