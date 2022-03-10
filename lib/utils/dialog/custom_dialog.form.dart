// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String SearchCountryValueKey = 'searchCountry';

mixin $CustomDialog on StatelessWidget {
  final TextEditingController searchCountryController = TextEditingController();
  final FocusNode searchCountryFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    searchCountryController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            SearchCountryValueKey: searchCountryController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    searchCountryController.dispose();
    searchCountryFocusNode.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get searchCountryValue => this.formValueMap[SearchCountryValueKey];

  bool get hasSearchCountry =>
      this.formValueMap.containsKey(SearchCountryValueKey);
}

extension Methods on FormViewModel {}
