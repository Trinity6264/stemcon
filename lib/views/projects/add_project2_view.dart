import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stemcon/shared/shared_button.dart';
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
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<NewProjectViewModel>.reactive(
      onDispose: (model) {
        disposeForm();
      },
      onModelReady: (model) {
        DateTime d = DateTime.now();
        model.selectedTimeZone = d.toString();
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
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: RadioListTile(
                          groupValue: model.unit,
                          value: 'MM',
                          title: const Text("MM"),
                          onChanged: model.onChangedUnit,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: RadioListTile(
                          groupValue: model.unit,
                          value: 'Ft',
                          title: const Text("Ft"),
                          onChanged: model.onChangedUnit,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: RadioListTile(
                          groupValue: model.unit,
                          value: 'CM',
                          title: const Text("CM"),
                          onChanged: model.onChangedUnit,
                        ),
                      ),
                    ],
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
                  Container(
                    width: double.infinity,
                    height: _size.height * 0.2 / 2.8,
                    padding: const EdgeInsets.only(left: 10.0),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: blackColor, width: 1.2),
                    ),
                    child: Text(model.selectedTimeZone),
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
                      : SharedButton(
                          title: 'SUBMIT',
                          onPressed: () => model.submitData(
                            userId: userId,
                            token: token,
                            id: id,
                            timeZone: model.selectedTimeZone,
                            adminStatus: adminStatus,
                            workingHour: workingHourController.text.trim(),
                            purpose: purposeController.text.trim(),
                            keyPoints: keyPointsController.text.trim(),
                            address: addressController.text.trim(),
                          ),
                        )
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
