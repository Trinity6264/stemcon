// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String CompanyCodeValueKey = 'companyCode';

mixin $CompanyCodeView on StatelessWidget {
  final TextEditingController companyCodeController = TextEditingController();
  final FocusNode companyCodeFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    companyCodeController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            CompanyCodeValueKey: companyCodeController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    companyCodeController.dispose();
    companyCodeFocusNode.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get companyCodeValue => this.formValueMap[CompanyCodeValueKey];

  bool get hasCompanyCode => this.formValueMap.containsKey(CompanyCodeValueKey);
}

extension Methods on FormViewModel {}
