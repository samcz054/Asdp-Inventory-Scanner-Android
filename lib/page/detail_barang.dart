// import 'dart:convert';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:http/http.dart' as http;

// class DetailBarang {
//   String nama_peminjam;
//   String gambar;
//   String nama_barang;
//   String kode_barang;
//   String nomor_seri;

//   DetailBarang({
//     this.nama_peminjam,
//     this.gambar,
//     this.nama_barang,
//     this.kode_barang,
//     this.nomor_seri,
//   });

//   factory DetailBarang.createDetailBarang(Map<String, dynamic> object) {
//     return DetailBarang(
//       nama_peminjam: object['nama_peminjam'],
//       gambar: object['gambar'],
//       nama_barang: object['nama_barang'],
//       kode_barang: object['kode_barang'],
//       nomor_seri: object['nomor_seri'],
//     );
//   }

//   static Future<DetailBarang> connectAPI(String kode_barang) async {
//     String apiURL = "http://127.0.0.1:8000/api/detail";
//     String getKode = "";

//     var APIdetailBarang = await http.post(
//       Uri.parse(apiURL),
//       headers: {"Accept": "application/json"},
//       body: {"kode_barang": getKode},
//     );

//     var jsonObject = json.decode(APIdetailBarang.body);

//     Future scanBarcode() async {
//       getKode = await FlutterBarcodeScanner.scanBarcode(
//           "#FFEA00", "Batal", true, ScanMode.DEFAULT);
//     }

//     return DetailBarang.createDetailBarang(jsonObject);
//   }
// }
