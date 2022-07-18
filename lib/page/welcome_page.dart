// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, unnecessary_brace_in_string_interps, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:androidbarcode/page/detail_page.dart';
import 'package:androidbarcode/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class HomePageWidget extends StatefulWidget {
  // const HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  // Fungsi Scan
  Future _scanDetailBarang() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#fce303", "Batal", true, ScanMode.DEFAULT)
        .then((getKode_barang) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DetailPage(getKode_barang)));
    });
  }

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
                color: Color(0xFFEEEEEE),
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
                            color: Color.fromARGB(255, 28, 99, 183),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            onPressed: () {
                              // Scan Barcode
                              _scanDetailBarang();
                            },
                            child: Text(
                              'Scan Barcode',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
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
                            color: Color.fromARGB(255, 28, 99, 183),
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
                                fontWeight: FontWeight.w600,
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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonTheme(
                          minWidth: 150,
                          child: RaisedButton(
                            color: Color.fromARGB(255, 28, 99, 183),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: Text(
                              'Pengembalian',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: () {
                              _pengembalian();
                            },
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
                            color: Color.fromARGB(255, 28, 99, 183),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: Text(
                              'Peminjam',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: () {
                              _peminjaman();
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

  Future _pengembalian() async {
    //
    // final getKode_barang = await FlutterBarcodeScanner.scanBarcode(
    //     "#fce303", "Batal", true, ScanMode.BARCODE);

    String getKode_barang = await scanner.scan();

    if (getKode_barang == null) {
      print('Kosong');
    } else {
      final response = await http.post(
        Uri.parse('http://192.168.1.8:8000/api/peminjaman/kembali/'),
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

  Future _peminjaman() async {
    //
    String getKode_barang = await scanner.scan();

    if (getKode_barang == null) {
      print('Kosong');
    } else {
      var nama_peminjam = TextEditingController();

      await Alert(
        context: context,
        title: "Masukkan nama peminjam",
        content: Column(
          children: <Widget>[
            TextField(
              controller: nama_peminjam,
              decoration: InputDecoration(
                labelText: 'Nama Peminjam',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              final response = await http.post(
                Uri.parse('http://192.168.1.8:8000/api/peminjaman/pinjam/'),
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
              } else if (response.statusCode == 201) {
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
