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
      // body: Container(
      //   width: double.infinity,
      //   height: double.infinity,
      //   child: Column(
      //     children: <Widget>[
      //       Expanded(
      //         child: Container(
      //           color: Color(0xffacfff),
      //         ),
      //       ),
      //       Expanded(
      //         child: Container(
      //           color: Colors.white,
      //         ),
      //       )
      //     ],
      //   ),
      // ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 40),
                    child: (widget.detailBarang.gambarBarang != null)
                        ? Image.network(
                            'https://asdpbarcodeinventory.herokuapp.com/fotobarang/${widget.detailBarang.gambarBarang}',
                            width: MediaQuery.of(context).size.width * 0.5,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/not_found.png',
                            width: MediaQuery.of(context).size.width * 0.5,
                            fit: BoxFit.cover,
                          ),
                  ),
                ],
              ),
            ),
            Text(
              "Nama Barang :         ${widget.detailBarang.namaBarang}",
              textAlign: TextAlign.justify,
            ),
            Text("Nomor Seri :         ${widget.detailBarang.nomorSeri}"),
            Text("Nama Peminjam :         ${widget.detailBarang.namaPeminjam}"),
            Text("Keterangan :"),
            (widget.detailBarang.keteranganBarang != null)
                ? Text("${widget.detailBarang.keteranganBarang}")
                : Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Text("Belum ada spesifikasi barang"),
                  ),
          ],
        ),
      ),
    );
  }
}
