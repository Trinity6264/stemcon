// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String NameValueKey = 'name';
const String AssignToValueKey = 'assignTo';
const String DescriptionValueKey = 'description';

mixin $TaskView on StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController assignToController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode assignToFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    nameController.addListener(() => _updateFormData(model));
    assignToController.addListener(() => _updateFormData(model));
    descriptionController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            NameValueKey: nameController.text,
            AssignToValueKey: assignToController.text,
            DescriptionValueKey: descriptionController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    nameController.dispose();
    nameFocusNode.dispose();
    assignToController.dispose();
    assignToFocusNode.dispose();
    descriptionController.dispose();
    descriptionFocusNode.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get nameValue => this.formValueMap[NameValueKey];
  String? get assignToValue => this.formValueMap[AssignToValueKey];
  String? get descriptionValue => this.formValueMap[DescriptionValueKey];

  bool get hasName => this.formValueMap.containsKey(NameValueKey);
  bool get hasAssignTo => this.formValueMap.containsKey(AssignToValueKey);
  bool get hasDescription => this.formValueMap.containsKey(DescriptionValueKey);
}

extension Methods on FormViewModel {}
