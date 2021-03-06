// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, unnecessary_brace_in_string_interps, prefer_const_literals_to_create_immutables, non_constant_identifier_names, deprecated_member_use, unused_local_variable, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:androidbarcode/modelBarang.dart';
import 'package:androidbarcode/page/detail_page.dart';
import 'package:androidbarcode/page/login_page.dart';
import 'package:androidbarcode/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';

class HomePageWidget extends StatefulWidget {
  // const HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // Fungsi Scan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: bgColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 130, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'SELAMAT DATANG',
                            style: GoogleFonts.poppins(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'ASDP INVENTORY SCANNER',
                            style: GoogleFonts.poppins(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 80),
                          child: SvgPicture.network(
                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/barcode-app-8lvbvg/assets/mls7m412no1q/Logo_ASDP.svg',
                            width: MediaQuery.of(context).size.width * 0.7,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonTheme(
                          minWidth: 150,
                          child: RaisedButton(
                            color: mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            onPressed: () {
                              // Scan Barcode
                              _detailBarangScan();
                            },
                            child: Text(
                              'Scan Barcode',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonTheme(
                          minWidth: 150,
                          child: RaisedButton(
                            color: mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {
                              print('Login Menu');
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginPage();
                              }));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _detailBarangScan() async {
    String getKode_barang = await scanner.scan();

    if (getKode_barang == null) {
      // gagal sacan
      print("Kosong");
    } else {
      final response = await http.get(
        Uri.parse(
            'https://asdpbarcodeinventory.herokuapp.com/api/detail/${getKode_barang}'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 201) {
        final detailBarang = jsonDecode(response.body);
        DetailBarang details = DetailBarang.fromJson(detailBarang);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => DetailPage(detailBarang: details)),
          ),
        );
      } else {
        Alert(
          context: context,
          title: "Kode ${getKode_barang} tidak ada dalam daftar inventaris",
          type: AlertType.error,
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
      }
    }
  }

  Future _pengembalianScan() async {
    String getKode_barang = await scanner.scan();

    if (getKode_barang == null) {
      print('Kosong');
    } else {
      final response = await http.post(
        Uri.parse(
            'https://asdpbarcodeinventory.herokuapp.com/api/peminjaman/kembali'),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'kode_barang': getKode_barang,
        },
      );
      if (response.statusCode == 201) {
        Alert(
          context: context,
          title: "${getKode_barang} berhasil dikembalikan",
          type: AlertType.success,
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
      } else {
        Alert(
          context: context,
          title: "Barang yang di scan sudah dikembalikan atau tidak terdaftar",
          type: AlertType.error,
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
      }
    }
  }

  Future _peminjamanScan(BuildContext context) async {
    //
    final GlobalKey<State> key = GlobalKey<State>();

    String getKode_barang = await scanner.scan();

    if (getKode_barang == null) {
      print('Kosong');
    } else {
      var nama_peminjam = TextEditingController();

      await Alert(
        context: context,
        title: "$getKode_barang Masukkan nama peminjam",
        content: Form(
          key: formkey,
          child: Column(
            children: <Widget>[
              TextField(
                controller: nama_peminjam,
                decoration: InputDecoration(
                  labelText: 'Nama Peminjam',
                ),
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              final response = await http.post(
                Uri.parse(
                    'https://asdpbarcodeinventory.herokuapp.com/api/peminjaman/pinjam'),
                headers: {
                  'Accept': 'application/json',
                },
                body: {
                  'kode_barang': getKode_barang,
                  'nama_peminjam': nama_peminjam.text,
                },
              );
              if (getKode_barang == null) {
                print("Gagal scan");
              } else if (nama_peminjam.text.isEmpty) {
                Alert(
                  context: context,
                  title: "Harap isi nama peminjam",
                  type: AlertType.error,
                  buttons: [
                    DialogButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Ok",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                ).show().then((value) => Navigator.pop(context));
              } else if (response.statusCode == 201) {
                Alert(
                  context: context,
                  title: "${getKode_barang} berhasil dipinjam",
                  type: AlertType.success,
                  buttons: [
                    DialogButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Ok",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                ).show().then((value) => Navigator.pop(context));
              } else {
                Alert(
                  context: context,
                  title:
                      "Barang yang di scan saat ini sudah dipinjam atau tidak terdaftar",
                  type: AlertType.error,
                  buttons: [
                    DialogButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Ok",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                ).show();
              }
            },
            child: Text(
              "Simpan",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ).show();
    }

    //
  }
}
