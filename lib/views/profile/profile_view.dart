import 'package:cached_network_image/cached_network_image.dart';
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
  final int userId;
  final int token;
  final int checkId;
  final String photoId;
  ProfileView({
    Key? key,
    required this.userId,
    required this.token,
    required this.checkId,
    required this.photoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<AddProfileViewModel>.reactive(
      onDispose: (model) {
        disposeForm();
      },
      onModelReady: (model) {
        if (checkId == 1) {
          model.downloadUserInfo(
            id: photoId,
            userId: userId,
            token: token,
          );
          return;
        }
      },
      viewModelBuilder: () => AddProfileViewModel(),
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            model.toDashBoard();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: model.toDashBoard,
                icon: const Icon(Icons.arrow_back),
              ),
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
                        child: model.profileImageUrl != null &&
                                model.imageSelected == null
                            ? Container(
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7.0),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'http://stemcon.likeview.in/${model.profileImageUrl!}',
                                    placeholder: (_, __) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorWidget: (_, __, ___) {
                                      return SvgPicture.asset(
                                        'assets/logo/undraw.svg',
                                        height: _size.height * 0.2,
                                      );
                                    },
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                              )
                            : model.imageSelected == null
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
                      decoration: textInputDecor.copyWith(
                        hintText: model.profileName ?? 'Enter name',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: postController,
                      textInputAction: TextInputAction.next,
                      decoration: textInputDecor.copyWith(
                        hintText: model.profilePost ?? 'Enter post',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: numberController,
                      focusNode: numberFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      decoration: textInputDecor.copyWith(
                        hintText: model.profileNumber ?? 'Enter phone number',
                      ),
                    ),
                    const SizedBox(height: 20),
                    model.isBusy
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                numberFocusNode.unfocus();
                                model.addProfile(
                                  token: token,
                                  userId: userId,
                                  name: nameController.text,
                                  post: postController.text,
                                  number: numberController.text,
                                );
                              },
                              child: const Text('SUBMIT'),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
