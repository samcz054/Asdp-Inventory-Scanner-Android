// ignore_for_file: prefer_const_constructors, no_logic_in_create_state, unnecessary_string_interpolations

import 'package:flutter/material.dart';

import '../modelBarang.dart';

class DetailPage extends StatefulWidget {
  final DetailBarang detailBarang;
  const DetailPage({Key key, this.detailBarang}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState(detailBarang);
}

class _DetailPageState extends State<DetailPage> {
  _DetailPageState(DetailBarang detailBarang);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 80),
                child: (widget.detailBarang.gambarBarang != null)
                    ? Image.network(
                        'https://asdpbarcodeinventory.herokuapp.com/fotobarang/${widget.detailBarang.gambarBarang}',
                        width: MediaQuery.of(context).size.width * 0.7,
                        fit: BoxFit.cover,
                      )
                    : Text("Gambar tidak tersedia"),
              ),
            ],
          ),
        ),
        Text("Nama Barang : ${widget.detailBarang.namaBarang}"),
        Text("Nomor Seri : ${widget.detailBarang.nomorSeri}"),
        Text("Nama Peminjam : ${widget.detailBarang.namaPeminjam}"),
        Text("Keterangan :"),
        (widget.detailBarang.keteranganBarang != null)
            ? Text("${widget.detailBarang.keteranganBarang}")
            : Text("Belum ada spesifikasi barang"),
      ],
    ));
  }
}
