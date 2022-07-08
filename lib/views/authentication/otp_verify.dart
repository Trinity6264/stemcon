import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../models/new_user.dart';
import '../../services/api_service.dart';
import '../../services/shared_prefs_service.dart';
import '../../utils/color/color_pallets.dart';

class OtpVerify extends StatefulWidget {
  final String companyCode;
  final String countryCode;
  final String countryNumber;
  const OtpVerify({
    Key? key,
    required this.companyCode,
    required this.countryCode,
    required this.countryNumber,
  }) : super(key: key);

  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> with CodeAutoFill {
  final _navService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _apiService = locator<ApiService>();
  final _prefsService = locator<SharedPrefsservice>();
  bool isBusy = false;
  String otpCode = '';
  int? token;

  void back() {
    _navService.back();
  }

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code!;
    });
  }

  @override
  void initState() {
    super.initState();
    listenForCode();
    generateToken();
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  //
  void generateToken() {
    token = Random().nextInt(999999);
  }

  void setBusy(bool fn) {
    setState(() {
      isBusy = fn;
    });
  }

  void matchingOtp() async {
    setBusy(true);
    try {
      final cornfirmOtp = ConfirmOtp(
        mobileNumber: widget.countryNumber.toString(),
        otp: int.parse(otpCode),
        token: token,
      );
      final response = await _apiService.cornfirmOtp(cornfirmOtp: cornfirmOtp);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['res_code'] == "1") {
          // persist data to local storage
          await _prefsService.savedUserState(1);
          await _prefsService.savedUserData(
            key: 'id',
            value: data['res_data']['id'],
            index: 0,
          );
          await _prefsService.savedUserData(
            key: 'company_code',
            value: data['res_data']['company_code'],
            index: 1,
          );
          await _prefsService.savedUserData(
            key: 'country_code',
            value: data['res_data']['country_code'],
            index: 1,
          );
          await _prefsService.savedUserData(
            key: 'mobile_number',
            value: data['res_data']['mobile_number'],
            index: 1,
          );
          await _prefsService.savedUserData(
            key: 'otp',
            value: data['res_data']['otp'],
            index: 1,
          );
          await _prefsService.savedUserData(
            key: 'is_admin',
            value: data['res_data']['is_admin'],
            index: 1,
          );
          await _prefsService.savedUserData(
            key: 'status',
            value: data['res_data']['status'],
            index: 1,
          );
          await _prefsService.savedUserData(
            key: 'authentication_token',
            value: data['res_data']['authentication_token'],
            index: 0,
          );
          await _prefsService.savedUserData(
            key: 'created_at',
            value: data['res_data']['created_at'],
            index: 1,
          );
          await _prefsService.savedUserData(
            key: 'updated_at',
            value: data['res_data']['updated_at'],
            index: 1,
          );
          
          _navService.pushNamedAndRemoveUntil(Routes.homeView);
          setBusy(false);
          return;
        } else {
          setBusy(false);
          _dialogService.showDialog(
            title: 'Authentication',
            description: data['res_message'],
          );
        }
      } else {
        final data = jsonDecode(response.body);
        setBusy(false);
        _dialogService.showDialog(
          title: 'Failed',
          description: data['res_message'],
        );
      }
    } on SocketException catch (e) {
      setBusy(false);
      _dialogService.showDialog(
        title: 'Failed',
        description: e.message,
      );
      return;
    } on Exception catch (e) {
      setBusy(false);
      _dialogService.showDialog(
        title: 'Failed',
        description: e.toString(),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: whiteColor,
        title: const Text(
          'OTP Verification',
          style: TextStyle(
            color: blackColor,
            fontFamily: 'Roboto-Medium',
            fontSize: 24.0,
          ),
        ),
      ),
      backgroundColor: whiteColor,
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: _size.height * 0.2),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Enter otp sent to ${widget.countryCode} ${widget.countryNumber}',
                style: const TextStyle(
                  fontFamily: 'Roboto-Medium',
                  fontSize: 16.0,
                  color: textColor,
                ),
              ),
            ),
            SizedBox(height: _size.height * 0.01),
            PinFieldAutoFill(
              codeLength: 4,
              decoration: const UnderlineDecoration(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                colorBuilder: FixedColorBuilder(
                  borderColor,
                ),
              ),
              currentCode: otpCode,
              onCodeChanged: (code) {
                if (code!.length == 4) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  otpCode = code;
                  matchingOtp();
                }
              },
            ),
            SizedBox(height: _size.height * 0.03),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Don\'t receive OTP?  ',
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 16.0,
                      fontFamily: 'Roboto-Regular',
                    ),
                  ),
                  TextSpan(
                    text: 'RESEND',
                    style: const TextStyle(
                      color: blackColor,
                      fontSize: 16.0,
                      fontFamily: 'Roboto-Medium',
                    ),
                    recognizer: TapGestureRecognizer()..onTap = back,
                  ),
                ],
              ),
            ),
            SizedBox(height: _size.height * 0.01),
            isBusy
                ? const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: LinearProgressIndicator(),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
