import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/view_models/authentication_view_model.dart';
import 'package:stemcon/views/authentication/login_view.form.dart';

import '../../shared/logo_size.dart';
import '../../utils/dialog/custom_dialog.dart';

@FormView(fields: [
  FormTextField(name: 'number'),
])
class LoginView extends StatelessWidget with $LoginView {
  final int? companyCode;
  LoginView({
    Key? key,
    this.companyCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<AuthenticationViewModel>.reactive(
      onModelReady: (model) => model.getSignature(),
      viewModelBuilder: () => AuthenticationViewModel(),
      builder: (context, model, child) {
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
                        width: double.infinity,
                        height: _size.height * 0.09,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: greyColor,
                            width: 0.8,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: _size.height * 0.1 - 40),
                    SizedBox(
                      child: TextField(
                        controller: numberController,
                        keyboardType: TextInputType.number,
                        maxLength: 15,
                        decoration: const InputDecoration(
                          labelText: 'Mobile number',
                          counter: Text(''),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    model.isBusy
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            height: _size.height * 0.1 / 1.8,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                              ),
                              onPressed: () {
                                model.toOtpView(
                                  companyCode: companyCode!,
                                  number: numberController.text,
                                );
                              },
                              child: const Text(
                                'LOG IN',
                                style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: _size.height * 0.1),
                    Row(
                      children: const [
                        Expanded(
                            child: Divider(
                          color: greyColor,
                          thickness: 1.0,
                        )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text('Login into app/signup'),
                        ),
                        Expanded(
                            child: Divider(
                          color: greyColor,
                          thickness: 1.0,
                        )),
                      ],
                    ),
                    SizedBox(height: _size.height * 0.1 / 5),
                    Container(
                      width: double.infinity,
                      child: const Text(
                        'By continuing you indicate that\nyou have read and agreed to the',
                      ),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 45),
                      height: _size.height * 0.1,
                    ),
                    const Text(
                      'Terms and Services',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: _size.height * 0.1 / 3),
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
