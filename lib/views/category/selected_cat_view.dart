import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/views/category/dpr/dpr_view.dart';
import 'package:stemcon/views/category/tasks/task_view.dart';

import '../../view_models/selected_view_model.dart';

// ignore: camel_case_types
class selectedCatViews extends StatelessWidget {
  final int? userId;
  final int? token;
  final String? projectId;
  const selectedCatViews({
    Key? key,
    required this.userId,
    required this.token,
    required this.projectId,
  }) : super(key: key);

  static const _navBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Task'),
    BottomNavigationBarItem(icon: Icon(Icons.note_add_outlined), label: 'DPR'),
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectedViewModel>.reactive(
      viewModelBuilder: () => SelectedViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: whiteColor,
          body: getViewFormIndex(model.currentIndex, userId!, token!),
          bottomNavigationBar: BottomNavigationBar(
            items: _navBarItems,
            currentIndex: model.currentIndex,
            onTap: model.setIndex,
          ),
        );
      },
    );
  }

  Widget? getViewFormIndex(int index, int userId, int token) {
    switch (index) {
      case 0:
        return TaskView(id: userId, token: token, projectId: projectId!);

      case 1:
        return DprView(token: token, userId: userId, projectId: projectId!);

      default:
        return TaskView(id: userId, token: token, projectId: projectId!);
    }
  }

  Widget icnBtn({
    required Widget icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      color: blackColor,
    );
  }
}
