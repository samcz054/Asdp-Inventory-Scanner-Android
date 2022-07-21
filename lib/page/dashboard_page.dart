// ignore_for_file: annotate_overrides, unnecessary_brace_in_string_interps, prefer_const_constructors, unnecessary_new, use_build_context_synchronously, unused_element, non_constant_identifier_names, avoid_print, unused_local_variable, deprecated_member_use, sort_child_properties_last

import 'dart:convert';

import 'package:androidbarcode/page/welcome_page.dart';
import 'package:androidbarcode/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:qrscan/qrscan.dart' as scanner;

import '../modelBarang.dart';
import 'detail_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String userName = "";

  @override
  void initState() {
    super.initState();
    getToken();
  }

  void getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userName = preferences.get('login');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 30, 99, 183),
        title: Text(
          "Selamat Datang ${userName}",
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Sign Out"),
                      onTap: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.clear();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomePageWidget()),
                            ((route) => false));
                      },
                    ),
                  ])
        ],
      ),
      // Dasboard menu
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              //
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, right: 0.0, top: 30.0, bottom: 0.0),
                child: new RaisedButton(
                    elevation: 0.0,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    padding: EdgeInsets.only(
                        top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SvgPicture.network(
                          'https://www.freepnglogos.com/uploads/among-us-png/green-among-us-png-character-0.png',
                          height: 40.0,
                          width: 40.0,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Galler  ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.0),
                            ))
                      ],
                    ),
                    textColor: Color(0xFF292929),
                    color: Colors.blueAccent),
              ),
              //

              //
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
                          'Peminjaman Barang',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          _peminjamanScan();
                        },
                      ),
                    ),
                  ],
                ),
              ),

              //

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
                          'Pengembalian Barang',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          _pengembalianScan();
                        },
                      ),
                    ),
                  ],
                ),
              ),

              //
            ],
          ),
        )),
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

  Future _peminjamanScan() async {
    String getKode_barang = await scanner.scan();

    if (getKode_barang == null) {
      print('Kosong');
    } else {
      var nama_peminjam = TextEditingController();

      await Alert(
        context: context,
        title: "$getKode_barang Masukkan nama peminjam",
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

  Future _pengembalianScan() async {
    String getKode_barang = await scanner.scan();

    if (getKode_barang == null) {
      // cancel Scan
      print('Kosong');
    } else {
      // scan result
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
        // successfull response
        Alert(
          context: context,
          title: " Barang dengan kode ${getKode_barang} berhasil dikembalikan",
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
}
