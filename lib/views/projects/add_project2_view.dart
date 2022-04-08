import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:stemcon/shared/shared_button.dart';
import 'package:stemcon/shared/text_input_decor.dart';
import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/view_models/add_project2_view_model.dart';
import 'package:stemcon/views/projects/add_project2_view.form.dart';
import 'package:stemcon/views/projects/selectable_widget.dart';

import '../../view_models/home_view_model.dart';

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
  final String? adminStatus;
  final CheckingState state;
  final String? projectAddress;
  final String? projectAdmin;
  final String? projectCode;
  final String? projectKeyPoint;
  final String? projectManHour;
  final String? projectPurpose;
  final String? projectStatus;
  final String? projectUnit;
  final String? projectTimeZone;
  AddProject2View({
    Key? key,
    required this.userId,
    required this.token,
    required this.id,
    required this.adminStatus,
    required this.state,
    this.projectAddress,
    this.projectAdmin,
    this.projectCode,
    this.projectKeyPoint,
    this.projectManHour,
    this.projectPurpose,
    this.projectStatus,
    this.projectUnit,
    this.projectTimeZone,
  }) : super(key: key);

  static final List<Color> _colors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.yellow,
    Colors.indigo,
    Colors.brown,
  ];

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<NewProjectViewModel>.reactive(
      onDispose: (model) {
        disposeForm();
      },
      onModelReady: (model) {
        model.requestTime();
        model.generatingManWorkingHour();
      },
      viewModelBuilder: () => NewProjectViewModel(),
      builder: (context, model, child) {
        final isEditting = state.index == 0;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: whiteColor,
            leading: IconButton(
              onPressed: () => model.back(),
              icon: const Icon(Icons.close, color: blackColor),
            ),
            elevation: 0,
            title: Text(
              isEditting ? 'Editting Project' : 'Add Project',
              style: const TextStyle(
                color: blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                              groupValue: isEditting &&
                                      projectUnit != null &&
                                      model.unit == ''
                                  ? projectUnit
                                  : model.unit,
                              value: 'MM',
                              title: const Text("MM"),
                              onChanged: model.onChangedUnit,
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: RadioListTile(
                              groupValue: isEditting &&
                                      projectUnit != null &&
                                      model.unit == ''
                                  ? projectUnit
                                  : model.unit,
                              value: 'Ft',
                              title: const Text("Ft"),
                              onChanged: model.onChangedUnit,
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: RadioListTile(
                              groupValue: isEditting &&
                                      projectUnit != null &&
                                      model.unit == ''
                                  ? projectUnit
                                  : model.unit,
                              value: 'CM',
                              title: const Text("CM"),
                              onChanged: model.onChangedUnit,
                            ),
                          ),
                        ],
                      ),
                      titleWidget(text: 'Man Working Hour'),
                      Container(
                        width: double.infinity,
                        height: _size.height * 0.2 / 2.3,
                        padding: const EdgeInsets.only(left: 10.0),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: blackColor, width: 1.2),
                        ),
                        child: DropdownButtonFormField(
                          items: model.manWorkingHour
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e.toString(),
                                  child: Text(e.toString()),
                                ),
                              )
                              .toList(),
                          hint: Text(
                            isEditting &&
                                    model.manHour == '' &&
                                    projectManHour != null
                                ? projectManHour!
                                : model.manHour,
                          ),
                          onChanged: model.onChangedManHour,
                        ),
                      ),
                      titleWidget(text: 'Purpose Of Project'),
                      TextField(
                        controller: purposeController,
                        decoration: textInputDecor.copyWith(
                            hintText: projectPurpose ?? 'Resudance'),
                      ),
                      titleWidget(text: 'Time Zone'),
                      Container(
                        width: double.infinity,
                        height: _size.height * 0.2 / 2.3,
                        padding: const EdgeInsets.only(left: 10.0),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: blackColor, width: 1.2),
                        ),
                        child: DropdownButtonFormField(
                          items: model.listOfselectedTimeZone
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),
                          // todo: time
                          hint: Text(projectTimeZone ?? model.selectedTimeZone),
                          value: model.selectedTimeZone,
                          onChanged: model.onChangedTime,
                        ),
                      ),
                      titleWidget(text: 'Key Points'),
                      TextField(
                        controller: keyPointsController,
                        decoration: textInputDecor.copyWith(
                            hintText: projectKeyPoint ?? 'Points'),
                      ),
                      titleWidget(text: 'Address'),
                      TextField(
                        controller: addressController,
                        decoration: textInputDecor.copyWith(
                            hintText: projectAddress ?? 'Address'),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Member List',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SelectableWidget(onChnaged: (value) {
                                      model.gettingSelectedNumber(value);
                                    });
                                  },
                                );
                              },
                              child: const Text(
                                'ADD MEMBER',
                                style: TextStyle(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                primary: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      model.listOfContact.isEmpty
                          ? const SizedBox.shrink()
                          : Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: model.listOfContact
                                  .map(
                                    (e) => SizedBox(
                                      width: double.infinity,
                                      height: _size.height * 0.1,
                                      child: Card(
                                        shadowColor: greyColor,
                                        elevation: 3.0,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                            top: 2,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Contractor ',
                                                style: TextStyle(
                                                  color: greyColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    e.displayName!,
                                                    style: const TextStyle(
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.arrow_right,
                                                    color: blackColor,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                e.phones!.isEmpty
                                                    ? 'none'
                                                    : e.phones
                                                            ?.elementAt(0)
                                                            .value ??
                                                        '',
                                                style: const TextStyle(
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                      SizedBox(height: _size.height * 0.1),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: 80,
                  width: double.infinity,
                  color: Colors.white,
                  child: model.isBusy
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SharedButton(
                          title: 'SUBMIT',
                          onPressed: () {
                            if (isEditting) {
                              model.editSubmitData(
                                userId: userId,
                                token: token,
                                id: id,
                                adminStatus: adminStatus == ''
                                    ? projectStatus!
                                    : adminStatus!,
                                workingHour: model.manHour == '1'
                                    ? projectManHour!
                                    : model.manHour,
                                purpose: purposeController.text == ''
                                    ? projectPurpose!
                                    : purposeController.text.trim(),
                                keyPoints: keyPointsController.text == ''
                                    ? projectKeyPoint!
                                    : keyPointsController.text.trim(),
                                address: addressController.text == ''
                                    ? projectAddress!
                                    : addressController.text.trim(),
                                timeZone: model.selectedTimeZone == ''
                                    ? projectTimeZone!
                                    : model.selectedTimeZone,
                              );
                            } else {
                              model.submitData(
                                userId: userId,
                                token: token,
                                id: id,
                                timeZone: model.selectedTimeZone,
                                adminStatus: adminStatus!,
                                workingHour: model.manHour,
                                purpose: purposeController.text.trim(),
                                keyPoints: keyPointsController.text.trim(),
                                address: addressController.text.trim(),
                              );
                            }
                          }),
                ),
              ),
            ],
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
