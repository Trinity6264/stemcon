import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/app/app.router.dart';

class TaskWrapperView extends StatelessWidget {
  const TaskWrapperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedNavigator(
        router: TaskWrapperViewRouter(),
        navigatorKey: StackedService.nestedNavigationKey(1),
      ),
    );
  }
}
