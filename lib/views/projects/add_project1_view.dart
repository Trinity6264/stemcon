import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stemcon/shared/shared_button.dart';

import 'package:stemcon/shared/text_input_decor.dart';
import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/view_models/add_project_view_model.dart';
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
  AddProjectView({
    Key? key,
    required this.userId,
    required this.token,
    required this.adminStatus,
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
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: whiteColor,
            title: const Text(
              'Add Project',
              style: TextStyle(
                color: blackColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      model.picImage();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: double.infinity,
                      height: _size.height * 0.3 / 1.2,
                      child: model.imageSelected != null
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
                    hintText: 'Eg: Gokul Mathura',
                    title: 'Project name-site',
                    controller: projectNameController,
                  ),
                  textField(
                    hintText: 'Eg: C100',
                    title: 'Project Code',
                    controller: projectCodeController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: SizedBox(
                          child: ElevatedButton(
                            onPressed: () =>
                                startDate(context: context, model: model),
                            child: Text(model.startDate ?? "Start Date"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      Flexible(
                        child: SizedBox(
                          child: ElevatedButton(
                            onPressed: () =>
                                endDate(context: context, model: model),
                            child: Text(model.endDate ?? "End Date"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  model.isBusy
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SharedButton(
                          title: 'CREATE PROJECT',
                          onPressed: () {
                            model.addProject(
                              projectCode: projectCodeController.text.trim(),
                              projectName: projectNameController.text.trim(),
                              token: token,
                              userId: userId,
                              adminStatus: adminStatus,
                            );
                          },
                        ),
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
