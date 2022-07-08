// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String ProjectNameValueKey = 'projectName';
const String ProjectCodeValueKey = 'projectCode';
const String OrganisationValueKey = 'organisation';

mixin $AddProjectView on StatelessWidget {
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController projectCodeController = TextEditingController();
  final TextEditingController organisationController = TextEditingController();
  final FocusNode projectNameFocusNode = FocusNode();
  final FocusNode projectCodeFocusNode = FocusNode();
  final FocusNode organisationFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    projectNameController.addListener(() => _updateFormData(model));
    projectCodeController.addListener(() => _updateFormData(model));
    organisationController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            ProjectNameValueKey: projectNameController.text,
            ProjectCodeValueKey: projectCodeController.text,
            OrganisationValueKey: organisationController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    projectNameController.dispose();
    projectNameFocusNode.dispose();
    projectCodeController.dispose();
    projectCodeFocusNode.dispose();
    organisationController.dispose();
    organisationFocusNode.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get projectNameValue => this.formValueMap[ProjectNameValueKey];
  String? get projectCodeValue => this.formValueMap[ProjectCodeValueKey];
  String? get organisationValue => this.formValueMap[OrganisationValueKey];

  bool get hasProjectName => this.formValueMap.containsKey(ProjectNameValueKey);
  bool get hasProjectCode => this.formValueMap.containsKey(ProjectCodeValueKey);
  bool get hasOrganisation =>
      this.formValueMap.containsKey(OrganisationValueKey);
}

extension Methods on FormViewModel {}
