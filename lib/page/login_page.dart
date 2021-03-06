// ignore_for_file: prefer_const_constructors, override_on_non_overriding_member, deprecated_member_use, non_constant_identifier_names, sort_child_properties_last, use_key_in_widget_constructors, use_build_context_synchronously, annotate_overrides, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:androidbarcode/page/dashboard_page.dart';
import 'package:androidbarcode/widgets/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:androidbarcode/page/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  void initState() {
    super.initState();
    loginCheck();
  }

  void loginCheck() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String value = preferences.getString("login");
    if (value != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Dashboard()),
          ((route) => false));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pop(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePageWidget();
                          }));
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.network(
                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/barcode-app-8lvbvg/assets/mls7m412no1q/Logo_ASDP.svg',
                        width: MediaQuery.of(context).size.width * 0.7,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ASDP Inventory Scanner',
                      style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 83, 83, 83),
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login Page',
                        style: GoogleFonts.poppins(
                          color: Color.fromARGB(255, 97, 97, 97),
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Field Email
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 8, 24, 0),
                  child: SizedBox(
                    width: 280,
                    child: TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Masukkan Email',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: mainColor,
                          ),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: mainColor),
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    ),
                  ),
                ),

                // Field Password
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 18, 24, 0),
                  child: SizedBox(
                    width: 280,
                    child: TextFormField(
                      controller: password,
                      enableSuggestions: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Masukkan Password',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: mainColor),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: mainColor),
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    ),
                  ),
                ),

                // Login Button
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: ButtonTheme(
                    minWidth: 150,
                    child: RaisedButton(
                      color: mainColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
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
                        _Login(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _Login(context) async {
    if (email.text.isEmpty && password.text.isEmpty) {
      Alert(
          context: context,
          type: AlertType.error,
          title: "Email dan Password harus diisi",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ]).show();
      return;
    }
    if (email.text.isEmpty) {
      Alert(
          context: context,
          type: AlertType.error,
          title: "Email harus diisi",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ]).show();
      return;
    }
    if (password.text.isEmpty) {
      Alert(
          context: context,
          type: AlertType.error,
          title: "Password harus diisi",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ]).show();
      return;
    }
    final response = await http.post(
      Uri.parse("https://asdpbarcodeinventory.herokuapp.com/api/login"),
      body: {
        'email': email.text,
        'password': password.text,
      },
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      // print("Login Token :" + body["access_token"]);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString("login", body["name"]);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ));
    } else if (response.statusCode == 500) {
      Alert(
          context: context,
          title: "Tidak ada koneksi internet",
          type: AlertType.error,
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ]).show();
    } else {
      Alert(
          context: context,
          title: "Login Gagal",
          type: AlertType.error,
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ]).show();
    }
  }
}
