class DetailBarang {
  final int kodeBarang;
  final String namaPeminjam;
  final String namaBarang;
  final String nomorSeri;

  const DetailBarang({
    this.kodeBarang,
    this.namaPeminjam,
    this.namaBarang,
    this.nomorSeri,
  });

  factory DetailBarang.fromJson(Map<String, dynamic> json) {
    return DetailBarang(
      kodeBarang: json['kode_barang'],
      namaPeminjam: json['nama_peminjam'],
      namaBarang: json['nama_barang'],
      nomorSeri: json['nomor_seri'],
    );
  }
}
