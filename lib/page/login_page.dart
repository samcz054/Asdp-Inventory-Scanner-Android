import 'package:androidbarcode/page/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                child: TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),

              // Field Password
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 8, 24, 0),
                child: TextFormField(
                  controller: password,
                ),
              ),

              // Login Button
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                child: ButtonTheme(
                  minWidth: 150,
                  child: RaisedButton(
                    color: Color.fromARGB(255, 30, 99, 183),
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
    );
  }

  Future _Login(context) async {
    if (email.text.isEmpty || password.text.isEmpty) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Email dan Password harus diisi",
      ).show();
      return;
    }
    final response = await http.post(
      Uri.parse("http://192.168.1.8:8000/api/login"),
      body: {
        'email': email.text,
        'password': password.text,
      },
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      Alert(
        context: context,
        title: "Login Berhasil",
        type: AlertType.success,
      ).show();
    } else {
      Alert(
        context: context,
        title: "Login Gagal",
        type: AlertType.error,
      ).show();
    }
  }
}
