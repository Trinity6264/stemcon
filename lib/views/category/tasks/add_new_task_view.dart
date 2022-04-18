import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:stemcon/shared/shared_button.dart';
import 'package:stemcon/shared/text_input_decor.dart';
import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/view_models/add_new_task_view_model.dart';
import 'package:stemcon/view_models/home_view_model.dart';
import 'package:stemcon/views/category/tasks/add_new_task_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'task1'),
  FormTextField(name: 'description'),
])
class AddNewTaskView extends StatelessWidget with $AddNewTaskView {
  final int userId;
  final int token;
  final String taskName;
  final String taskAssignedBy;
  final String projectId;
  final CheckingState state;
  final String? description;
  final String? taskStatus;
  final String? taskId;

  AddNewTaskView({
    Key? key,
    required this.userId,
    required this.token,
    required this.taskName,
    required this.taskAssignedBy,
    required this.projectId,
    required this.state,
    this.description,
    this.taskStatus,
    this.taskId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<AddTaskViewModel>.reactive(
        viewModelBuilder: () => AddTaskViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: model.back,
                icon: const Icon(Icons.arrow_back),
              ),
              elevation: 0.0,
              backgroundColor: whiteColor,
              automaticallyImplyLeading: false,
              title: Text(
                'Add New Task',
                style: TextStyle(
                  color: blackColor,
                  fontSize: (_size.width * 0.1) / 1.8,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            backgroundColor: whiteColor,
            body: WillPopScope(
              onWillPop: () async {
                model.backHome();
                return false;
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'SELECTED WORK CATEGORY',
                            style: TextStyle(
                              color: greyColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
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
                    ),
                    Text(
                      taskName,
                      style: const TextStyle(
                        color: blackColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: task1Controller,
                      decoration: textInputDecor.copyWith(
                        hintText: 'Task 1',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: descriptionController,
                      decoration: textInputDecor.copyWith(
                        hintText: 'Description',
                      ),
                    ),
                    const Spacer(),
                    model.isBusy
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 30,
                            ),
                            child: SharedButton(
                              title: 'Add Task',
                              onPressed: () => model.addTask(
                                taskName: taskName,
                                description: descriptionController.text.trim(),
                                token: token,
                                userId: userId,
                                projectId: projectId,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
