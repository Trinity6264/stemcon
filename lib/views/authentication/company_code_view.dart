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
    return ViewModelBuilder<StartUpViewModel>.reactive(
      viewModelBuilder: () => StartUpViewModel(),
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
                    'Your Company code is here!!!!',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextField(
                  controller: companyCodeController,
                  keyboardType: TextInputType.phone,
                  decoration: textInputDecor.copyWith(
                    labelText: 'Company code',
                  ),
                ),
                const SizedBox(height: 10.0),
                SharedButton(
                  title: 'Next',
                  onPressed: () => model.toLoginView(
                    int.parse(companyCodeController.text),
                    companyCodeController.text,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
