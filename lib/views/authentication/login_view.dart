import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stemcon/shared/shared_button.dart';

import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/view_models/authentication_view_model.dart';
import 'package:stemcon/views/authentication/login_view.form.dart';

import '../../shared/logo_size.dart';
import '../../shared/text_input_decor.dart';
import '../../utils/dialog/custom_dialog.dart';

@FormView(fields: [
  FormTextField(name: 'number'),
])
class LoginView extends StatelessWidget with $LoginView {
  final String? companyCode;
  LoginView({
    Key? key,
    this.companyCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<AuthenticationViewModel>.reactive(
      onDispose: (model) => disposeForm(),
      onModelReady: (model) => model.getSignature(),
      viewModelBuilder: () => AuthenticationViewModel(),
      builder: (context, model, child) {
        debugPrint(_size.height.toString());
        return Scaffold(
          backgroundColor: whiteColor,
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: (15 / _size.height) * 100),
                    const LogoSize(),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 26),
                      child: const Text(
                        'STEMCON',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto-Medium',
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    SizedBox(height: _size.height * 0.1 / 100),
                    GestureDetector(
                      onTap: () async {
                        await showDialog(
                            useRootNavigator: false,
                            context: context,
                            builder: (context) {
                              return CustomDialog(
                                onChanged: model.getCountryCode,
                              );
                            });
                      },
                      child: Container(
                        width: 343,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      model.countryCode!.flag!,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(model.countryCode!.callingCode!),
                                ],
                              ),
                            ),
                            const SizedBox(
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: blackColor,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: borderColor,
                            width: 0.8,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 50,
                      width: 343,
                      child: TextField(
                        controller: numberController,
                        keyboardType: TextInputType.phone,
                        decoration: textInputDecor.copyWith(
                          labelText: 'Mobile number',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    model.isBusy
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SharedButton(
                            title: 'LOG IN',
                            onPressed: () => model.toOtpView(
                              companyCode: companyCode!,
                              number: numberController.text,
                            ),
                          ),
                    SizedBox(height: (150 / _size.height) * 100),
                    SizedBox(
                      width: _size.width / 1.3,
                      child: Row(
                        children: const [
                          Expanded(
                              child: Divider(
                            color: borderColor,
                            thickness: 1.0,
                          )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              'Login into app/signup',
                              style: TextStyle(
                                color: borderColor,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            color: borderColor,
                            thickness: 1.0,
                          )),
                        ],
                      ),
                    ),
                    SizedBox(height: _size.height * 0.1 / 3),
                    Container(
                      width: double.infinity,
                      child: const Text(
                        'By continuing you indicate that\nyou have read and agreed to the',
                        style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                          color: borderColor,
                        ),
                      ),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(bottom: 10),
                      height: _size.height * 0.1,
                    ),
                    const Text(
                      'Terms and Services',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Roboto-Bold',
                      ),
                    ),
                    // SizedBox(height: _size.height * 0.1 / 2),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
