import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/view_models/drp_view_model.dart';
import 'package:stemcon/views/category/dpr/editting_dpr_view.form.dart';

import '../../../models/dpr_list_model.dart';
import '../../../shared/text_input_decor.dart';

@FormView(fields: [
  FormTextField(name: 'description'),
])
class EdittingDprView extends StatelessWidget with $EdittingDprView {
  final DprListModel data;
  final int token;
  final int userId;
  EdittingDprView({
    Key? key,
    required this.data,
    required this.token,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<DprViewModel>.reactive(
      viewModelBuilder: () => DprViewModel(),
      onDispose: (model) => disposeForm(),
      builder: (_, model, ___) {
        return Center(
          child: Container(
            height: size.height * 0.5,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Edit Dpr',
                      style: TextStyle(
                        color: blackColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: descriptionController,
                      decoration: textInputDecor.copyWith(
                        hintText: data.dprTime ?? 'Dpr Description',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: descriptionController,
                      decoration: textInputDecor.copyWith(
                        hintText: data.dprDescription ?? 'Dpr Description',
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => endDate(context: context, model: model),
                      child: Container(
                        padding: const EdgeInsets.only(top: 15, left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: greyColor,
                            width: 0.5,
                          ),
                        ),
                        height: (size.height * 0.1 / 3) + 20,
                        width: double.infinity,
                        child: Text(
                          model.dateTime ?? data.dprTime ?? 'Dpr time',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: model.isBusy == true
                          ? const LinearProgressIndicator()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                              ),
                              onPressed: () {
                                model.editRequest(
                                  token: token,
                                  userId: userId,
                                  description:
                                      descriptionController.text.isEmpty
                                          ? data.dprDescription
                                          : descriptionController.text.trim(),
                                  projectId: data.projectId,
                                  dprPdf: model.imageSelected,
                                  dprTime: model.dateTime ?? data.dprTime ?? '',
                                  id: data.id,
                                );
                              },
                              child: const Text('Edit DPR'),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
          ),
        );
      },
    );
  }

  Future endDate({
    required BuildContext context,
    required DprViewModel model,
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
