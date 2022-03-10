import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:stacked/stacked.dart';
import 'package:stemcon/shared/logo_size.dart';

import '../../utils/color/color_pallets.dart';
import '../../view_models/otp_view_model.dart';

class OtpView extends StatelessWidget {
  final int companyCode;
  const OtpView({Key? key, required this.companyCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<OtpViewModel>.reactive(
      onModelReady: (model) {
        model.generateToken();
        model.listenForIncomingMessage();
      },
      viewModelBuilder: () => OtpViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: whiteColor,
          body: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoSize(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    'StemCon',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: _size.height * 0.1 / 30),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Code will be filled automatically',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(height: _size.height * 0.01),
                PinFieldAutoFill(
                  codeLength: 4,
                  decoration: UnderlineDecoration(
                    textStyle: const TextStyle(fontSize: 20, color: blackColor),
                    colorBuilder: FixedColorBuilder(
                      blackColor.withOpacity(0.3),
                    ),
                  ),
                  currentCode: model.otpCode,
                  onCodeChanged: (code) {
                    model.otpCode = code.toString();
                    if (code != null) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      model.matchingOtp(companyCode: companyCode);
                    }
                  },
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
