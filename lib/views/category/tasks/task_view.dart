import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stemcon/shared/text_input_decor.dart';

import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/view_models/task_view_model.dart';
import 'package:stemcon/views/category/tasks/task_view.form.dart';

import '../../../models/add_task_model.dart';

@FormView(fields: [
  FormTextField(name: 'name'),
  FormTextField(name: 'assignTo'),
  FormTextField(name: 'description'),
])
class TaskView extends StatelessWidget with $TaskView {
  TaskView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<TaskViewModel>.reactive(
      onModelReady: (model) {
        model.loadData();
        print(model.projectId);
      },
      viewModelBuilder: () => TaskViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
              onPressed: model.back,
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            backgroundColor: whiteColor,
            title: Text(
              "Add Task",
              style: TextStyle(
                color: blackColor,
                fontSize: (_size.width * 0.1) / 1.8,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          backgroundColor: whiteColor,
          body: model.isBusy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: model.datas.isEmpty
                      ? Center(
                          child: SvgPicture.asset(
                            'assets/logo/undraw.svg',
                          ),
                        )
                      : ListView.builder(
                          itemCount: model.datas.length,
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          itemBuilder: (context, index) {
                            final data = model.datas[index];

                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 15,
                              ),
                              width: double.infinity,
                              height: (_size.height * 0.2) + 15,
                              child: Card(
                                shadowColor: greyColor,
                                elevation: 3.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.taskName ?? 'Empty',
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        data.description ?? 'Empty',
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.only(
                                          top: 20,
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            button(
                                              size: _size,
                                              color: greenColor,
                                              text: 'Edit',
                                            ),
                                            button(
                                              size: _size,
                                              color: redColor,
                                              text: 'Delete',
                                              onPressed: () {
                                                model.deleteTask(
                                                  token: model.token!,
                                                  userId: model.userId!,
                                                  index: index,
                                                  id: model.projectId!,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
        );
      },
    );
  }

  GestureDetector button({
    required Size size,
    required Color color,
    required String text,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size.width * 0.2,
        height: size.height * 0.1 - 30,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: greyColor,
            width: 0.5,
          ),
        ),
      ),
    );
  }

  void showCustomDialog(
    BuildContext context,
    AddTaskModel model,
    Size size,
    TaskViewModel contoller,
    TextEditingController? nameController,
    TextEditingController? desController,
    String userId,
    String token,
  ) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: size.height * 0.5,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Edit Task',
                    style: TextStyle(
                      color: blackColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    decoration: textInputDecor.copyWith(
                      hintText: model.taskName ?? 'Task name',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: desController,
                    decoration: textInputDecor.copyWith(
                      hintText: model.description ?? 'Task Description',
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: contoller.isEdittingTask == true
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                            ),
                            onPressed: () {
                              contoller
                                  .editTask(
                                taskName: nameController?.text == ''
                                    ? model.taskName
                                    : nameController?.text,
                                description: desController?.text == ''
                                    ? model.description
                                    : desController?.text,
                                projectId: model.projectId ?? '',
                                taskAssignedBy: model.taskAssignedBy,
                                token: token,
                                userId: userId,
                                id: model.id,
                              )
                                  .then((value) {
                                nameController?.clear();
                                descriptionController.clear();
                              });
                            },
                            child: const Text('Edit Task'),
                          ),
                  ),
                ],
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
