// ignore_for_file: file_names

import 'dart:convert';

class DetailBarang {
  final int kodeBarang;
  final String namaPeminjam;
  final String namaBarang;
  final String nomorSeri;
  final String gambarBarang;
  final String keteranganBarang;

  const DetailBarang({
    this.kodeBarang,
    this.namaPeminjam,
    this.namaBarang,
    this.nomorSeri,
    this.gambarBarang,
    this.keteranganBarang,
  });

  factory DetailBarang.fromJson(Map<String, dynamic> json) {
    return DetailBarang(
      kodeBarang: jsonDecode(json['kode_barang'].toString()),
      namaPeminjam: json['nama_peminjam'],
      namaBarang: json['nama_barang'],
      nomorSeri: json['nomor_seri'],
      gambarBarang: json['gambar'],
      keteranganBarang: json['keterangan'],
    );
  }
}
