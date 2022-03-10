// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String NumberValueKey = 'number';

mixin $LoginView on StatelessWidget {
  final TextEditingController numberController = TextEditingController();
  final FocusNode numberFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    numberController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            NumberValueKey: numberController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    numberController.dispose();
    numberFocusNode.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get numberValue => this.formValueMap[NumberValueKey];

  bool get hasNumber => this.formValueMap.containsKey(NumberValueKey);
}

extension Methods on FormViewModel {}
