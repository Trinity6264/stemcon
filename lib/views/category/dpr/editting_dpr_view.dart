import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      onModelReady: (model) {
        print(token);
        print(userId);
      },
      viewModelBuilder: () => DprViewModel(),
      builder: (_, model, ___) {
        return Center(
          child: Container(
            height: size.height * 0.8,
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
                    GestureDetector(
                      onTap: model.picImage,
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        height: size.height * 0.3 / 1.2,
                        child:
                            data.dprPdf != null && model.imageSelected == null
                                ? Container(
                                    width: double.infinity,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'http://stemcon.likeview.in${data.dprPdf}',
                                      fit: BoxFit.cover,
                                      placeholder: (_, __) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                      width: double.infinity,
                                      errorWidget: (_, __, ___) {
                                        return SvgPicture.asset(
                                          'assets/logo/undraw.svg',
                                          height: size.height * 0.2,
                                        );
                                      },
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  )
                                : Center(
                                    child: model.imageSelected != null
                                        ? Image.file(
                                            model.imageSelected!,
                                            fit: BoxFit.cover,
                                            width: double.infinity - 20,
                                            // height: size.height * 0.3 / 1.2,
                                          )
                                        : Column(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/logo/undraw.svg',
                                                height: size.height * 0.2,
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: greyColor,
                            width: 0.5,
                          ),
                        ),
                        height: (size.height * 0.1 / 3) + 20,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            model.dateTime ?? data.dprTime ?? 'Dpr time',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: model.isEdittingTask == true
                          ? const LinearProgressIndicator()
                          : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                            ),
                              onPressed: () {
                                if (model.imageSelected == null &&
                                    descriptionController.text.isEmpty &&
                                    model.dateTime == null) {
                                  return;
                                } else {
                                  model.editTask(
                                    token: token,
                                    userId: userId,
                                    description:
                                        descriptionController.text.isEmpty
                                            ? data.dprDescription
                                            : descriptionController.text.trim(),
                                    projectId: data.projectId,
                                    dprPdf: model.imageSelected,
                                    dprTime:
                                        model.dateTime ?? data.dprTime ?? '',
                                    id: data.id,
                                  );
                                }
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
