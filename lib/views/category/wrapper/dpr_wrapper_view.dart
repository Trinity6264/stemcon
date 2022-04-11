import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.router.dart';

class DprWrapper extends StatelessWidget {
  const DprWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedNavigator(
        router: DprWrapperRouter(),
        navigatorKey: StackedService.nestedNavigationKey(2),
      ),
    );
  }
}
