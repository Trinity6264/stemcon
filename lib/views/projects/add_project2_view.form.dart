// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String WorkingHourValueKey = 'workingHour';
const String PurposeValueKey = 'purpose';
const String KeyPointsValueKey = 'keyPoints';
const String AddressValueKey = 'address';

mixin $AddProject2View on StatelessWidget {
  final TextEditingController workingHourController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController keyPointsController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final FocusNode workingHourFocusNode = FocusNode();
  final FocusNode purposeFocusNode = FocusNode();
  final FocusNode keyPointsFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    workingHourController.addListener(() => _updateFormData(model));
    purposeController.addListener(() => _updateFormData(model));
    keyPointsController.addListener(() => _updateFormData(model));
    addressController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            WorkingHourValueKey: workingHourController.text,
            PurposeValueKey: purposeController.text,
            KeyPointsValueKey: keyPointsController.text,
            AddressValueKey: addressController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    workingHourController.dispose();
    workingHourFocusNode.dispose();
    purposeController.dispose();
    purposeFocusNode.dispose();
    keyPointsController.dispose();
    keyPointsFocusNode.dispose();
    addressController.dispose();
    addressFocusNode.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get workingHourValue => this.formValueMap[WorkingHourValueKey];
  String? get purposeValue => this.formValueMap[PurposeValueKey];
  String? get keyPointsValue => this.formValueMap[KeyPointsValueKey];
  String? get addressValue => this.formValueMap[AddressValueKey];

  bool get hasWorkingHour => this.formValueMap.containsKey(WorkingHourValueKey);
  bool get hasPurpose => this.formValueMap.containsKey(PurposeValueKey);
  bool get hasKeyPoints => this.formValueMap.containsKey(KeyPointsValueKey);
  bool get hasAddress => this.formValueMap.containsKey(AddressValueKey);
}

extension Methods on FormViewModel {}
