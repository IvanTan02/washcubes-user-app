import 'package:device_run_test/config.dart';
import 'package:device_run_test/src/constants/sizes.dart';
import 'package:device_run_test/src/utilities/theme/widget_themes/outlinedbutton_theme.dart';
import 'package:device_run_test/src/utilities/theme/widget_themes/textfield_theme.dart';
import 'package:flutter/material.dart';
// import 'package:device_run_test/src/features/authentication/screens/signup/SignUpPage.dart';
import 'package:device_run_test/src/features/authentication/screens/userverification/OTPVerifyPage.dart';
import 'package:device_run_test/src/features/authentication/screens/home/HomePage.dart';
import 'package:device_run_test/src/constants/colors.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  TextEditingController phoneNumberController = TextEditingController();
  bool isNotValidate = false;
  String errorText = '';

  void phoneNumbervalidation() async {
    RegExp pattern = RegExp(r'^(601)[0-46-9][0-9]{7,8}$');
    if (phoneNumberController.text.isNotEmpty) {
      if (pattern.hasMatch(phoneNumberController.text)) {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => OTPVerifyPage()),
        );
        await http.post(Uri.parse(otpverification), body: {"phoneNumber": phoneNumberController.text});
      } else {
        setState(() {
          errorText = 'Invalid Phone Number Entered.';
          isNotValidate = true;
        });
      }
    } else {
      setState(() {
        errorText = 'Please Enter Your Phone Number.';
        isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(cDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logos/i3Cubes_logo.png', height: size.height * 0.2),
            const SizedBox(height: cDefaultSize,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: cFormHeight - 30),
              //width:  double.infinity,
              height:  cFormHeight + 75,
              child: Column(
                children: [
                  Form(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        inputDecorationTheme: CTextFormFieldTheme.lightInputDecorationTheme,
                      ),
                      child: TextField(
                        controller: phoneNumberController,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Enter Phone Number Starts with 60',
                          hintText: '60123456789', 
                          errorStyle: TextStyle(color: Colors.red),
                          errorText: isNotValidate ? errorText : null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {
                phoneNumbervalidation();
              },
              style: COutlinedButtonTheme.lightOutlinedButtonTheme.style,
              child: Center(
                  child: Text('Continue', style: Theme.of(context).textTheme.headlineMedium,),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text(
                'Continue as Guest', 
                style: TextStyle(decoration: TextDecoration.underline, color: AppColors.cGreyColor3,), 
              ),
            ),
            // Add more widgets as needed
          ],
        ),
      ),
    );
  }
}