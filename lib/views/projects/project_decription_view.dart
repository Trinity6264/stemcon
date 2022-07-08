import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:stemcon/models/project_list_model.dart';
import 'package:stemcon/utils/color/color_pallets.dart';

import '../../view_models/project_description_view_model.dart';

class ProjectDescriptionView extends StatelessWidget {
  final ProjectListModel projectModel;
  final String userId;
  final String token;
  const ProjectDescriptionView({
    Key? key,
    required this.projectModel,
    required this.userId,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<ProjectDescriptionViewModel>.nonReactive(
      viewModelBuilder: () => ProjectDescriptionViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            backgroundColor: whiteColor,
            elevation: 0.0,
            title: Text(
              projectModel.projectName ?? 'Project name',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto-Medium',
                color: blackColor,
                fontSize: 24.0,
              ),
            ),
          ),
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                Column(
                  children: [
                    textWidget(
                      'Project Code',
                      projectModel.projectCode ?? '-',
                      _size,
                    ),
                    textWidget(
                      'Project Name',
                      projectModel.projectName ?? '-',
                      _size,
                    ),
                    textWidget(
                      'Address',
                      projectModel.projectAddress ?? '-',
                      _size,
                    ),
                    textWidget(
                      'Purpose',
                      projectModel.projectPurpose ?? '-',
                      _size,
                    ),
                    textWidget(
                      'Key Points',
                      projectModel.projectKeyPoint ?? '-',
                      _size,
                    ),
                    textWidget(
                      'Start Date',
                      projectModel.projectStartDate ?? '-',
                      _size,
                    ),
                    textWidget(
                      'End Date',
                      projectModel.projectEndDate ?? '-',
                      _size,
                    ),
                    textWidget(
                      'Working Hour',
                      projectModel.projectManHour ?? '-',
                      _size,
                    ),
                    textWidget(
                      'Project Unit',
                      projectModel.projectUnit ?? '-',
                      _size,
                    ),
                    textWidget(
                      'Time Zone',
                      projectModel.projectTimezone ?? '-',
                      _size,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: _size.height * 0.1,
                    color: whiteColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        button(
                          onPressed: () {
                            model.toDprTaskView(0, projectModel.id.toString());
                          },
                          size: _size,
                          color: blackColor,
                          text: 'Task',
                        ),
                        GestureDetector(
                          onTap: () {
                            showCustomDialog(
                              context,
                              _size,
                              model,
                              projectModel,
                            );
                          },
                          child: Container(
                            width: _size.width * 0.2,
                            height: _size.height * 0.1 / 1.5,
                            child: const Icon(Icons.add, color: whiteColor),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        button(
                          onPressed: () {
                            model.toDprTaskView(1, projectModel.id.toString());
                          },
                          size: _size,
                          color: primaryColor,
                          text: 'Dpr',
                        ),
                      ],
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

  Widget textWidget(String key, String value, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.4,
            child: Text(
              "$key:",
              style: const TextStyle(
                color: textColor,
                fontSize: 16.0,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: blackColor,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
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
        width: size.width * 0.3,
        height: size.height * 0.1 - 30,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 20.0,
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
    Size size,
    ProjectDescriptionViewModel model,
    ProjectListModel projectModel,
  ) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.7),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            width: size.width * 0.6,
            height: (size.height * 0.2),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      model.toAddTaskDprView(
                        userId: userId,
                        token: token,
                        indes: 0,
                        projectId: projectModel.id?.toString(),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add,
                          color: blackColor,
                          size: 30.0,
                        ),
                        Text(
                          'Add Task',
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      model.toAddTaskDprView(
                        userId: userId,
                        token: token,
                        indes: 1,
                        projectId: projectModel.id?.toString(),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add,
                          color: blackColor,
                          size: 30.0,
                        ),
                        Text(
                          'Add DPR',
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
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
