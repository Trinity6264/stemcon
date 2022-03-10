// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String TaskValueKey = 'task';
const String TomorrowTaskValueKey = 'tomorrowTask';

mixin $AddNewDprView on StatelessWidget {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController tomorrowTaskController = TextEditingController();
  final FocusNode taskFocusNode = FocusNode();
  final FocusNode tomorrowTaskFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    taskController.addListener(() => _updateFormData(model));
    tomorrowTaskController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            TaskValueKey: taskController.text,
            TomorrowTaskValueKey: tomorrowTaskController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    taskController.dispose();
    taskFocusNode.dispose();
    tomorrowTaskController.dispose();
    tomorrowTaskFocusNode.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get taskValue => this.formValueMap[TaskValueKey];
  String? get tomorrowTaskValue => this.formValueMap[TomorrowTaskValueKey];

  bool get hasTask => this.formValueMap.containsKey(TaskValueKey);
  bool get hasTomorrowTask =>
      this.formValueMap.containsKey(TomorrowTaskValueKey);
}

extension Methods on FormViewModel {}
