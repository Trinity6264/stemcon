import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stemcon/shared/shared_button.dart';

import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/view_models/add_dpr_view_model.dart';

import '../../../shared/text_input_decor.dart';
import 'add_new_dpr_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'task'),
  FormTextField(name: 'tomorrowTask'),
])
class AddNewDprView extends StatelessWidget with $AddNewDprView {
  final int userId;
  final int token;
  final String projectId;
  final String taskName;
  AddNewDprView({
    Key? key,
    required this.userId,
    required this.token,
    required this.projectId,
    required this.taskName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<AddNewDprViewModel>.reactive(
      onModelReady: (model) => model.initDate(),
      viewModelBuilder: () => AddNewDprViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: whiteColor,
            // leading: IconButton(
            //   onPressed: model.back,
            //   icon: const Icon(Icons.arrow_back),
            // ),
            title: Text(
              'Add New DPR',
              style: TextStyle(
                color: blackColor,
                fontSize: (_size.width * 0.1) / 1.8,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          backgroundColor: whiteColor,
          body: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'SELECTED WORK CATEGORY',
                        style: TextStyle(
                          color: greyColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: model.back,
                        child: const Text(
                          'Change',
                          style: TextStyle(
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    taskName.toUpperCase(),
                    style: const TextStyle(
                      color: blackColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 18),
                  GestureDetector(
                    onTap: () => endDate(context: context, model: model),
                    child: Container(
                      width: double.infinity,
                      height: _size.height * 0.1 / 1.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: borderColor,
                        ),
                      ),
                      child: Text(
                        model.dateTime ?? "2022-4-6",
                        style: const TextStyle(
                          color: blackColor,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: taskController,
                    decoration: textInputDecor.copyWith(
                      hintText: 'Todays\'s Task',
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: model.picImage,
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
                          color: borderColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: tomorrowTaskController,
                    decoration: textInputDecor.copyWith(
                      hintText: 'Tomorrow Task',
                    ),
                  ),
                  SizedBox(height: _size.height * 0.1),
                  model.isBusy
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          child: SharedButton(
                            title: 'Add DPR',
                            onPressed: () => model.addDpr(
                              projectId: projectId,
                              dprDescription: taskController.text.trim(),
                              token: token,
                              userId: userId,
                            ),
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

  Future endDate({
    required BuildContext context,
    required AddNewDprViewModel model,
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
    model.onChanged(text: datePicked);
  }
}
