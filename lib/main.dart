import 'package:device_run_test/src/features/authentication/screens/home/HomePage.dart';
import 'package:device_run_test/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:device_run_test/src/utilities/theme/theme.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(token: prefs.getString('token'),));
}

class MyApp extends StatelessWidget {
  final token;
  const MyApp({
    @required this.token,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // themeMode: ThemeMode.system,
      title: 'WashCubes App',
      theme: CAppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: (token != null)
          ? HomePage(token: token)
          : WelcomeScreen());
  }
}
