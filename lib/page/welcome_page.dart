import 'dart:convert';

import 'package:androidbarcode/JsontoObj/detail_barang.dart';
import 'package:androidbarcode/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePageWidget extends StatefulWidget {
  // const HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  // Fungsi Scan
  String getKode_barang = "";
  Future _scanDetailBarang() async {
    getKode_barang = await FlutterBarcodeScanner.scanBarcode(
        "#fce303", "Batal", true, ScanMode.DEFAULT);
  }

  // Hasil scan
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
      throw Exception('Barang tidak terdaftar');
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
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
                              textStyle: Theme.of(context).textTheme.headline4,
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
                              textStyle: Theme.of(context).textTheme.headline4,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
