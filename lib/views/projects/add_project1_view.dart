import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:stemcon/shared/shared_button.dart';
import 'package:stemcon/shared/text_input_decor.dart';
import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/view_models/add_project_view_model.dart';
import 'package:stemcon/view_models/home_view_model.dart';
import 'package:stemcon/views/projects/add_project1_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'projectName'),
  FormTextField(name: 'projectCode'),
  FormTextField(name: 'organisation'),
])
class AddProjectView extends StatelessWidget with $AddProjectView {
  final int userId;
  final int token;
  final String adminStatus;
  // options args
  final String? projectname;
  final String? projectPhotoPath;
  final String? projectStartTime;
  final String? projectEndTime;
  final int? id;
  final CheckingState state;
  final String? projectAddress;
  final String? projectAdmin;
  final String? projectCode;
  final String? projectKeyPoint;
  final String? projectManHour;
  final String? projectPurpose;
  final String? projectStatus;
  final String? projectUnit;
  final String? projectTimezone;

  AddProjectView({
    Key? key,
    required this.userId,
    required this.token,
    required this.adminStatus,
    this.projectname,
    this.projectPhotoPath,
    this.projectStartTime,
    this.projectEndTime,
    this.id,
    required this.state,
    this.projectAddress,
    this.projectAdmin,
    this.projectCode,
    this.projectKeyPoint,
    this.projectManHour,
    this.projectPurpose,
    this.projectStatus,
    this.projectUnit,
    this.projectTimezone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<AddProjectViewModel>.reactive(
      viewModelBuilder: () => AddProjectViewModel(),
      onDispose: (model) {
        disposeForm();
      },
      builder: (context, model, child) {
        final isEditting = state.index == 0;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: whiteColor,
            title: const Text(
              'Add Project',
              style: TextStyle(
                color: blackColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      model.picImage();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: double.infinity,
                      height: _size.height * 0.3 / 1.2,
                      child: isEditting &&
                              projectPhotoPath != null &&
                              model.imageSelected == null
                          ? Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'http://stemcon.likeview.in$projectPhotoPath',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          : model.imageSelected != null
                              ? Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      image: FileImage(model.imageSelected!),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/logo/undraw.svg',
                                        height: _size.height * 0.2,
                                      ),
                                      const SizedBox(height: 5.0),
                                      const Text(
                                        'Tap to upload product image Here',
                                        style: TextStyle(
                                          color: greyColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          style: BorderStyle.solid,
                          width: 1.5,
                          color: greyColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  textField(
                    hintText: isEditting && projectname != null
                        ? projectname!
                        : 'Eg: Gokul Mathura',
                    title: 'Project name-site',
                    controller: projectNameController,
                  ),
                  textField(
                    hintText: isEditting && projectCode != null
                        ? projectCode!
                        : 'Eg: C100',
                    title: 'Project Code',
                    controller: projectCodeController,
                  ),
                  const Text('Start Date'),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () => startDate(context: context, model: model),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: double.infinity,
                      height: _size.height * 0.1 / 1.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: greyColor,
                        ),
                      ),
                      child: Text(
                        isEditting &&
                                projectStartTime != null &&
                                model.startDate == null
                            ? projectStartTime!
                            : model.startDate ?? "2022-05-01",
                        style: const TextStyle(
                          color: greyColor,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                    ),
                  ),
                  const Text('End Date'),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () => endDate(context: context, model: model),
                    child: Container(
                      width: double.infinity,
                      height: _size.height * 0.1 / 1.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: greyColor,
                        ),
                      ),
                      child: Text(
                        isEditting &&
                                projectEndTime != null &&
                                model.endDate == null
                            ? projectEndTime!
                            : model.endDate ?? "2024-06-01",
                        style: const TextStyle(
                          color: greyColor,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  model.isBusy
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SharedButton(
                          title: state.index == 0
                              ? 'Edit Project'
                              : 'CREATE PROJECT',
                          onPressed: () {
                            if (state.index == 0) {
                              model.editProject(
                                state,
                                image: model.imageSelected,
                                token: token,
                                userId: userId,
                                id: id,
                                projectEndTime: model.endDate ?? projectEndTime,
                                projectStartTime:
                                    model.startDate ?? projectStartTime,
                                projectCode: projectCodeController.text == ''
                                    ? projectCode
                                    : projectCodeController.text,
                                projectAddress: projectAddress,
                                projectName: projectNameController.text == ''
                                    ? projectname
                                    : projectNameController.text,
                                projectAdmin: projectAdmin,
                                projectKeyPoint: projectKeyPoint,
                                projectManHour: projectManHour,
                                projectPurpose: projectPurpose,
                                projectStatus: projectStatus,
                                projectUnit: projectUnit,
                              );
                            } else {
                              model.addProject(
                                projectCode: projectCodeController.text.trim(),
                                projectName: projectNameController.text.trim(),
                                token: token,
                                userId: userId,
                                image: model.imageSelected,
                                adminStatus: adminStatus,
                              );
                            }
                          },
                        ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget textField({
    required String title,
    required String hintText,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: blackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: controller,
            decoration: textInputDecor.copyWith(
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> startDate({
    required BuildContext context,
    required AddProjectViewModel model,
  }) async {
    final initial = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(initial.year - 10),
      lastDate: DateTime(initial.year + 10),
    );
    if (date == null) return null;
    final datePicked = "${date.year}-${date.month}-${date.day}";
    model.onChanged(index: 0, text: datePicked);
  }

  Future<DateTime?> endDate({
    required BuildContext context,
    required AddProjectViewModel model,
  }) async {
    final initial = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(initial.year - 10),
      lastDate: DateTime(initial.year + 10),
    );
    if (date == null) return null;
    final datePicked = "${date.year}-${date.month}-${date.day}";
    model.onChanged(index: 1, text: datePicked);
  }
}
