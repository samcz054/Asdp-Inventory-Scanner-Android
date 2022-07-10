import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailBarang {
  final int kode_barang;
  final String nama_peminjam;
  final String nama_barang;
  final String nomor_seri;

  const DetailBarang({
    required this.kode_barang,
    required this.nama_peminjam,
    required this.nama_barang,
    required this.nomor_seri,
  });

  factory DetailBarang.fromJson(Map<String, dynamic> json) {
    return DetailBarang(
      kode_barang: json['kode_barang'],
      nama_peminjam: json['nama_peminjam'],
      nama_barang: json['nomor_seri'],
      nomor_seri: json['nomor_seri'],
    );
  }
}
