// ignore_for_file: prefer_const_constructors, no_logic_in_create_state, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:androidbarcode/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    mainColor,
                    Color.fromARGB(255, 121, 168, 255),
                  ],
                ),
              ),
              child: Container(
                width: double.infinity,
                height: 420.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          height: 140,
                          width: 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: (widget.detailBarang.gambarBarang != null)
                                ? Image.network(
                                    'https://asdpbarcodeinventory.herokuapp.com/fotobarang/${widget.detailBarang.gambarBarang}')
                                : Image.asset('assets/images/not_found.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "${widget.detailBarang.namaBarang}",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 22, horizontal: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Nomor Seri",
                                      style: GoogleFonts.roboto(
                                        color: mainColor,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "${widget.detailBarang.nomorSeri}",
                                      style: GoogleFonts.roboto(
                                        color: mainColor,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Status",
                                      style: GoogleFonts.roboto(
                                        color: mainColor,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "${widget.detailBarang.namaPeminjam}",
                                      style: GoogleFonts.roboto(
                                        color: mainColor,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Kode",
                                      style: GoogleFonts.roboto(
                                        color: mainColor,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "${widget.detailBarang.kodeBarang}",
                                      style: GoogleFonts.roboto(
                                        color: mainColor,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (widget.detailBarang.keteranganBarang != null)
                      ? <Widget>[
                          Text(
                            "Spesifikasi :",
                            style: GoogleFonts.roboto(
                              color: mainColor,
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "${widget.detailBarang.keteranganBarang}",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ]
                      : <Widget>[
                          Text(
                            "Spesifikasi kosong / belum diisi",
                            style: GoogleFonts.roboto(
                              color: mainColor,
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
