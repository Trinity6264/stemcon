import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/view_models/task_view_model.dart';

class TaskView extends StatelessWidget {
  final int id;
  final int token;
  final String projectId;
  const TaskView({
    Key? key,
    required this.id,
    required this.token,
    required this.projectId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<TaskViewModel>.reactive(
      onModelReady: (model) {
        model.loadData(userId: id, token: token);
      },
      viewModelBuilder: () => TaskViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: whiteColor,
            title: const Text(
              "GOKUL MATHURA",
              style: TextStyle(
                color: blackColor,
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          backgroundColor: whiteColor,
          body: model.isBusy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    Container(
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
                                return GestureDetector(
                                  onTap: (){},
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: _size.height * 0.1 + 40,
                                    child: Card(
                                      shadowColor: greyColor,
                                      elevation: 3.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Task $index By . Darshan kasundra',
                                              style: const TextStyle(
                                                color: greyColor,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 5.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    data.taskName ?? 'Empty',
                                                    style: const TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        data.taskStatus ??
                                                            'pending',
                                                        style: const TextStyle(
                                                          color: primaryColor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      const Icon(
                                                          Icons.arrow_right),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Text(
                                              '+91 92446627462',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: _size.height * 0.1,
                        color: whiteColor,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            button(
                              onPressed: () {
                                model.toAddNewTaskView(
                                  token: token,
                                  userId: id,
                                  projectId: projectId,
                                );
                              },
                              size: _size,
                              color: blackColor,
                              icon: Icons.add,
                              text: 'Add Task',
                            ),
                            button(
                              size: _size,
                              color: primaryColor,
                              icon: Icons.format_align_left,
                              text: 'Filter',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  GestureDetector button({
    required Size size,
    required IconData icon,
    required Color color,
    required String text,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size.width * 0.4,
        height: size.height * 0.1 - 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
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
