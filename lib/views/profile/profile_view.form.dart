// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String NameValueKey = 'name';
const String PostValueKey = 'post';
const String NumberValueKey = 'number';

mixin $ProfileView on StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController postController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode postFocusNode = FocusNode();
  final FocusNode numberFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    nameController.addListener(() => _updateFormData(model));
    postController.addListener(() => _updateFormData(model));
    numberController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            NameValueKey: nameController.text,
            PostValueKey: postController.text,
            NumberValueKey: numberController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    nameController.dispose();
    nameFocusNode.dispose();
    postController.dispose();
    postFocusNode.dispose();
    numberController.dispose();
    numberFocusNode.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get nameValue => this.formValueMap[NameValueKey];
  String? get postValue => this.formValueMap[PostValueKey];
  String? get numberValue => this.formValueMap[NumberValueKey];

  bool get hasName => this.formValueMap.containsKey(NameValueKey);
  bool get hasPost => this.formValueMap.containsKey(PostValueKey);
  bool get hasNumber => this.formValueMap.containsKey(NumberValueKey);
}

extension Methods on FormViewModel {}
