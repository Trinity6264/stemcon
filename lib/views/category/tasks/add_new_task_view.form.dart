// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String Task1ValueKey = 'task1';
const String AssignToValueKey = 'assignTo';
const String DescriptionValueKey = 'description';

mixin $AddNewTaskView on StatelessWidget {
  final TextEditingController task1Controller = TextEditingController();
  final TextEditingController assignToController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FocusNode task1FocusNode = FocusNode();
  final FocusNode assignToFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    task1Controller.addListener(() => _updateFormData(model));
    assignToController.addListener(() => _updateFormData(model));
    descriptionController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            Task1ValueKey: task1Controller.text,
            AssignToValueKey: assignToController.text,
            DescriptionValueKey: descriptionController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    task1Controller.dispose();
    task1FocusNode.dispose();
    assignToController.dispose();
    assignToFocusNode.dispose();
    descriptionController.dispose();
    descriptionFocusNode.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get task1Value => this.formValueMap[Task1ValueKey];
  String? get assignToValue => this.formValueMap[AssignToValueKey];
  String? get descriptionValue => this.formValueMap[DescriptionValueKey];

  bool get hasTask1 => this.formValueMap.containsKey(Task1ValueKey);
  bool get hasAssignTo => this.formValueMap.containsKey(AssignToValueKey);
  bool get hasDescription => this.formValueMap.containsKey(DescriptionValueKey);
}

extension Methods on FormViewModel {}
