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

String getKode_barang = "";

Future _scanDetailBarang() async {
  getKode_barang = await FlutterBarcodeScanner.scanBarcode(
      "#fce303", "Batal", true, ScanMode.DEFAULT);
}

Future<DetailBarang> scanDetailBarangRes(String getKode_barang) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.8:8000/api/detail'),
    headers: <String, String>{
      'Accept': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'kode_barang': getKode_barang,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return DetailBarang.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Barang tidak terdaftar');
  }
}
