import 'package:device_run_test/src/constants/colors.dart';
import 'package:device_run_test/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:device_run_test/src/utilities/theme/theme.dart';
import 'package:device_run_test/src/utilities/theme/widget_themes/outlinedbutton_theme.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final token;
  const HomePage({this.token, Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late String userID;

  @override
  void initState() {
    super.initState();

    if (widget.token != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      userID = jwtDecodedToken['_id'];
    } else {
      userID = 'Guest';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => WelcomeScreen(),),(Route<dynamic> route) => false);
            },
          child: Icon(
            Icons.logout_rounded,
          ),
        )
      ),
      body: Center(
        child: Column(
          children: [
            Text('this is home page, and your userID is ' + userID.toString()),
          ],
        ),
      ),
    );
  }
}