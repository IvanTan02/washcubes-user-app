import 'package:device_run_test/src/constants/colors.dart';
import 'package:device_run_test/src/features/authentication/screens/biometricSetup/biometric_setup_screen.dart';
import 'package:device_run_test/src/features/authentication/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'package:device_run_test/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPVerifyPage extends StatefulWidget {
  const OTPVerifyPage({super.key});

  @override
  _OTPPageState createState() => _OTPPageState();
}
  
class _OTPPageState extends State<OTPVerifyPage> {

  late SharedPreferences prefs;
  TextEditingController phoneNumberController = TextEditingController();
  String currentText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void resendOTP() async {
    await http.post(Uri.parse(otpverification));
  }

  void otpValidation() async {
    var response = await http.post(Uri.parse(registration), body: {"otpRes": phoneNumberController.text});
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == 'existingUser') {
      var myToken = jsonResponse['token'];
      prefs.setString('token', myToken);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage(token: myToken),),(Route<dynamic> route) => false);
    } else if (jsonResponse['status'] == 'newUser') {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const BiometricSetupPage(),),(Route<dynamic> route) => false);
    } else if (jsonResponse['status'] == 'wrongOTP') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('The OTP entered is incorrect. Please try again.', style: Theme.of(context).textTheme.headlineMedium,),
            actions: [
              TextButton(
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop();
                },
                child: Text('OK', style: Theme.of(context).textTheme.headlineMedium,),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification', style: Theme.of(context).textTheme.displaySmall,),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30.0),
            Text('Enter the OTP sent to +60*********', style: Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: 30.0),
            //Pin Code Field
            PinCodeTextField(
              appContext: context,
              controller: phoneNumberController,
              length: 6,
              enableActiveFill: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              pastedTextStyle: Theme.of(context).textTheme.headlineMedium,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldWidth: 50,
                inactiveColor: AppColors.cPrimaryColor,
                selectedColor: AppColors.cPrimaryColor,
                activeFillColor: AppColors.cWhiteColor,
                selectedFillColor: AppColors.cWhiteColor,
                inactiveFillColor: AppColors.cWhiteColor,
                
              ),
              onChanged: (value) {
                setState(() {
                  // currentText = value;
                });
              },
              onCompleted: (value) {
                otpValidation();
              },
              beforeTextPaste: (text) {
                return true;
              },
            ),
            const SizedBox(height: 30.0),
            Text("Didn't receive OTP code?", style: Theme.of(context).textTheme.headlineMedium,),
            //OTP Resend Link
            TextButton(
              onPressed: () {resendOTP();},// Resend OTP Code
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Resend Code', 
                    style: TextStyle(color: AppColors.cBlueColor2, decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}