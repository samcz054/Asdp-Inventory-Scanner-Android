import 'dart:convert';

import 'package:androidbarcode/modelBarang.dart';
import 'package:androidbarcode/page/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  // const DetailPage({Key? key}) : super(key: key);
  final String getKode_barang;
  DetailPage(this.getKode_barang);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DetailBarang detailBarang;

  Future<DetailBarang> _scanGetDetail() async {
    await http
        .get(Uri.parse(
            "http://192.168.1.8:8000/api/detail/${widget.getKode_barang}/"))
        .then((response) {
      if (jsonDecode(response.body) != null) {
        setState(() {
          detailBarang = DetailBarang.fromJson(jsonDecode(response.body));
        });
      }
    });
    return detailBarang;
  }

  @override
  void iniState() {
    _scanGetDetail();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: detailBarang == null
          ? Center(
              child: Text(
                  "Barcode dengan kode ${widget.getKode_barang} tidak ditemukan"))
          : Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text("Code : ${detailBarang.kodeBarang}",
                        style: TextStyle(fontSize: 20)),
                    Text("Nama barang : ${detailBarang.namaBarang}",
                        style: TextStyle(fontSize: 20)),
                    Text("Status  : ${detailBarang.namaPeminjam}",
                        style: TextStyle(fontSize: 20)),
                    Text("Nomor Seri : ${detailBarang.nomorSeri}",
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ),
    );
  }
}
