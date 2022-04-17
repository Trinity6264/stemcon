import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stemcon/shared/logo_size.dart';
import 'package:stemcon/shared/shared_button.dart';
import 'package:stemcon/shared/text_input_decor.dart';
import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/view_models/startup_view_model.dart';

import 'package:stacked/stacked_annotations.dart';
import 'package:stemcon/views/authentication/company_code_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'companyCode'),
])
class CompanyCodeView extends StatelessWidget with $CompanyCodeView {
  CompanyCodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    // final re = (20 / _size.height)*100;
    // debugPrint(re.toString());
    return ViewModelBuilder<StartUpViewModel>.reactive(
      viewModelBuilder: () => StartUpViewModel(),
      onDispose: (model) {
        disposeForm();
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: whiteColor,
          // resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: _size.height * 0.25),
                  const LogoSize(),
                  const SizedBox(height: 14),
                  const Text(
                    'STEMCON',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto-Medium',
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Your Company code is here!!!!',
                      style: TextStyle(
                        // fontWeight: FontWeight.w300,
                        fontFamily: 'Roboto-Medium',
                        fontSize: 16.0,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 13.0),
                  SizedBox(
                    height: 50,
                    width: 343,
                    child: TextField(
                      controller: companyCodeController,
                      keyboardType: TextInputType.phone,
                      decoration: textInputDecor.copyWith(
                        labelText: 'Company code',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SharedButton(
                    title: 'Next',
                    onPressed: () => model.toLoginView(
                      companyCodeController.text,
                      companyCodeController.text,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
