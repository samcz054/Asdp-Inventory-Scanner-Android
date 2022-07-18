import 'package:androidbarcode/page/login_page.dart';
import 'package:androidbarcode/page/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String access_token = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  void getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      access_token = preferences.get('login');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              Text("welcome User"),
              Text("Token :"),
              Text(access_token),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                child: ButtonTheme(
                  minWidth: 150,
                  child: RaisedButton(
                    color: Color.fromARGB(255, 30, 99, 183),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => HomePageWidget()),
                          ((route) => false));
                    },
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
