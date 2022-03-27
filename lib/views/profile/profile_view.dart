import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stemcon/shared/text_input_decor.dart';
import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/view_models/add_profile_view_model.dart';
import 'package:stemcon/views/profile/profile_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'name'),
  FormTextField(name: 'post'),
  FormTextField(name: 'number'),
])
class ProfileView extends StatelessWidget with $ProfileView {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<AddProfileViewModel>.reactive(
      onModelReady: (model) => model.reload(),
      viewModelBuilder: () => AddProfileViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: whiteColor,
            elevation: 0,
            title: const Text(
              'Profile',
              style: TextStyle(
                color: blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: whiteColor,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _size.height * 0.1),
                  GestureDetector(
                    onTap: model.picImage,
                    child: Container(
                      width: _size.width * 0.5 - 20,
                      height: _size.height * 0.2,
                      child: model.imageSelected == null
                          ? SvgPicture.asset(
                              'assets/logo/undraw.svg',
                              height: _size.height * 0.2,
                            )
                          : Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                image: DecorationImage(
                                  image: FileImage(model.imageSelected!),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                      decoration: BoxDecoration(
                        border: Border.all(color: blackColor, width: 1.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    textInputAction: TextInputAction.next,
                    controller: nameController,
                    focusNode: nameFocusNode,
                    decoration: textInputDecor.copyWith(
                      hintText: 'Enter name',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: postController,
                    focusNode: postFocusNode,
                    textInputAction: TextInputAction.next,
                    decoration: textInputDecor.copyWith(
                      hintText: 'Enter post',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: numberController,
                    focusNode: numberFocusNode,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: textInputDecor.copyWith(
                      hintText: 'Enter phone number',
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        model.addProfile(
                          name: nameController.text.trim(),
                          post: postController.text.trim(),
                          number: numberController.text.trim(),
                        );
                      },
                      child: const Text('SUBMIT'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
