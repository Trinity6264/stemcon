import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stemcon/shared/logo_size.dart';
import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/view_models/startup_view_model.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<StartUpViewModel>.nonReactive(
      onModelReady: (model) => model.toCompanyView(),
      viewModelBuilder: () => StartUpViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: whiteColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                LogoSize(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'StemCon',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
