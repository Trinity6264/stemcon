import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stemcon/shared/text_input_decor.dart';
import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/view_models/add_project2_view_model.dart';
import 'package:stemcon/views/projects/add_project2_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'workingHour'),
  FormTextField(name: 'purpose'),
  FormTextField(name: 'keyPoints'),
  FormTextField(name: 'address'),
])
class AddProject2View extends StatelessWidget with $AddProject2View {
  final int userId;
  final int token;
  final int id;
  final String adminStatus;
  AddProject2View({
    Key? key,
    required this.userId,
    required this.token,
    required this.adminStatus,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewProjectViewModel>.reactive(
      onDispose: (model) {
        disposeForm();
      },
      viewModelBuilder: () => NewProjectViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: whiteColor,
            leading: IconButton(
              onPressed: () => model.back(),
              icon: const Icon(Icons.close, color: blackColor),
            ),
            elevation: 0,
            title: const Text(
              'Add Project',
              style: TextStyle(
                color: blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleWidget(text: 'Work unit'),
                  DropdownButtonFormField(
                    decoration: textInputDecor,
                    hint: const Text('MM'),
                    items: model.workingUnit.map((e) {
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    }).toList(),
                    onChanged: model.onChangedUnits,
                  ),
                  titleWidget(text: 'Man Working Hour'),
                  TextField(
                    controller: workingHourController,
                    decoration: textInputDecor.copyWith(hintText: '1400 HR'),
                  ),
                  titleWidget(text: 'Purpose Of Project'),
                  TextField(
                    controller: purposeController,
                    decoration: textInputDecor.copyWith(hintText: 'Resudance'),
                  ),
                  titleWidget(text: 'Time Zone'),
                  DropdownButtonFormField(
                    decoration: textInputDecor,
                    hint: const Text('KOLKATA 6:30'),
                    items: model.workingUnit.map((e) {
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    }).toList(),
                    onChanged: model.onChangedTime,
                  ),
                  titleWidget(text: 'Key Points'),
                  TextField(
                    controller: keyPointsController,
                    decoration: textInputDecor.copyWith(hintText: 'Pints'),
                  ),
                  titleWidget(text: 'Address'),
                  TextField(
                    controller: addressController,
                    decoration: textInputDecor.copyWith(hintText: 'Address'),
                  ),
                  const SizedBox(height: 20),
                  model.isBusy
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                            ),
                            onPressed: () {
                              model.submitData(
                                userId: userId,
                                token: token,
                                id: id,
                                adminStatus: adminStatus,
                                workingHour: workingHourController.text.trim(),
                                purpose: purposeController.text.trim(),
                                keyPoints: keyPointsController.text.trim(),
                                address: addressController.text.trim(),
                              );
                            },
                            child: const Text(
                              'SUBMIT',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                letterSpacing: 1.5,
                              ),
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

  Padding titleWidget({required String text}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 20.0, 0.0, 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: blackColor,
          fontWeight: FontWeight.w500,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
