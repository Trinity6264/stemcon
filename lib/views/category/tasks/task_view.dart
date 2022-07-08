import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/view_models/task_view_model.dart';

class TaskView extends StatelessWidget {
  final String projectId;
  const TaskView({
    Key? key,
    required this.projectId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<TaskViewModel>.reactive(
      onModelReady: (model) {
        model.loadData();
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/logo/undraw.svg',
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'No TASK found',
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
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
                                              onPressed: () {
                                                model.toEdit(
                                                  projectId: projectId,
                                                  taskName: data.taskName ?? '',
                                                  taskAssignedBy:
                                                      data.taskAssignedBy ?? '',
                                                  description:
                                                      data.description ?? '',
                                                  taskStatus:
                                                      data.taskStatus ?? '',
                                                  taskId: data.id!,
                                                );
                                              },
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
                                                  id: data.id!,
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
}
