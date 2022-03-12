import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:stemcon/shared/logo_size.dart';

import '../../shared/text_input_decor.dart';
import '../../utils/color/color_pallets.dart';
import '../../view_models/otp_view_model.dart';

class OtpView extends StatelessWidget {
  final int companyCode;
  final String countryCode;
  final String countryNumber;
  const OtpView({
    Key? key,
    required this.companyCode,
    required this.countryCode,
    required this.countryNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<OtpViewModel>.reactive(
      onModelReady: (model) {
        model.generateToken();
        model.listenForIncomingMessage(companyCode);
      },
      onDispose: (model) {
        model.controller1.dispose();
        model.controller2.dispose();
        model.controlle3.dispose();
        model.controlle4.dispose();
      },
      viewModelBuilder: () => OtpViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: whiteColor,
            title: const Text(
              'OTP Verification',
              style: TextStyle(
                color: blackColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          backgroundColor: whiteColor,
          body: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: _size.height * 0.1 / 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Enter otp sent to $countryCode $countryNumber',
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(height: _size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: _size.height * 0.1,
                      width: 50,
                      child: TextField(
                        controller: model.controller1,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        decoration: textInputDecor.copyWith(
                          counterText: '',
                          hintText: '-',
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    SizedBox(
                      height: _size.height * 0.1,
                      width: 50,
                      child: TextField(
                        controller: model.controller2,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        decoration: textInputDecor.copyWith(
                          counterText: '',
                          hintText: '-',
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    SizedBox(
                      height: _size.height * 0.1,
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: model.controlle3,
                        maxLength: 1,
                        decoration: textInputDecor.copyWith(
                          counterText: '',
                          hintText: '-',
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    SizedBox(
                      height: _size.height * 0.1,
                      width: 50,
                      child: TextField(
                        controller: model.controlle4,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        decoration: textInputDecor.copyWith(
                          counterText: '',
                          hintText: '-',
                        ),
                        textInputAction: TextInputAction.go,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: _size.height * 0.01),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Don\'t receive OTP?  ',
                        style: TextStyle(
                          color: blackColor,
                        ),
                      ),
                      TextSpan(
                        text: 'RESEND',
                        style: const TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.w800,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = model.back,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: _size.height * 0.01),
                model.isBusy
                    ? const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: LinearProgressIndicator(),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }
}
