import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:stemcon/shared/text_input_decor.dart';
import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/view_models/add_category_view_model.dart';
import 'package:stemcon/views/category/add_category_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'search'),
])
class AddCategoryView extends StatelessWidget with $AddCategoryView {
  final int? userId;
  final int? token;
  final int? indes;
  final String? projectId;
  AddCategoryView({
    Key? key,
    required this.userId,
    required this.token,
    required this.indes,
    this.projectId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddCategoryViewModel>.reactive(
      onDispose: (model) => disposeForm(),
      onModelReady: (model) {
        model.loadData(userId: userId!, token: token!);
      },
      viewModelBuilder: () => AddCategoryViewModel(),
      builder: (context, model, child) {
        Size _size = MediaQuery.of(context).size;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: whiteColor,
            automaticallyImplyLeading: false,
            title: Text(
              indes == 0 ? 'Add New Task' : 'Add New DPR',
              style: const TextStyle(
                color: blackColor,
                fontWeight: FontWeight.w700,
                fontSize: 16.5,
              ),
            ),
            actions: [
              IconButton(
                onPressed: model.goBack,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          backgroundColor: whiteColor,
          body: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'Create new work category',
                        style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    TextField(
                      controller: searchController,
                      decoration:
                          textInputDecor.copyWith(hintText: 'Type here...'),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'CHOOSE FROM',
                      style: TextStyle(
                        color: greyColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                      ),
                    ),
                    model.isBusy
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : !model.isBusy && model.datas.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: model.datas.length,
                                itemBuilder: (context, index) {
                                  final data = model.datas[index];
                                  return GestureDetector(
                                    onTap: () {
                                      model.toAddTaskView(
                                        userId: userId!,
                                        token: token!,
                                        taskName: data.suggestionTaskName!,
                                        index: indes!,
                                        projectId: projectId!,
                                      );
                                    },
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: _size.height * 0.1 + 20,
                                      child: Card(
                                        shadowColor: greyColor,
                                        elevation: 3.0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data.suggestionTaskName!,
                                                style: const TextStyle(
                                                  color: blackColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  icnBtn(
                                                    icon: const Icon(
                                                      Icons.delete_outlined,
                                                    ),
                                                    onPressed: () {
                                                      model.deleteData(
                                                        userId: userId!,
                                                        token: token!,
                                                        id: data.id!,
                                                        message: data
                                                            .suggestionTaskName!,
                                                      );
                                                    },
                                                  ),
                                                  icnBtn(
                                                    icon: const Icon(
                                                      Icons.edit_outlined,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        model.toAddTaskView(
                            userId: userId!,
                            token: token!,
                            taskName: searchController.text.trim(),
                            index: indes!,
                            projectId: projectId!);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                      ),
                      child: const Text('Next'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget icnBtn({
    required Widget icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      color: blackColor,
    );
  }
}
