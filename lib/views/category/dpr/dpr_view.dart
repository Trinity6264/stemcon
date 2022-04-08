import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stemcon/models/dpr_list_model.dart';
import 'package:stemcon/views/category/dpr/editting_dpr_view.dart';

import '../../../utils/color/color_pallets.dart';
import '../../../view_models/drp_view_model.dart';

class DprView extends StatelessWidget {
  final int token;
  final int userId;
  final String projectId;
  const DprView({
    Key? key,
    required this.token,
    required this.userId,
    required this.projectId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<DprViewModel>.reactive(
      onModelReady: (model) => model.loadData(userId: userId, token: token),
      viewModelBuilder: () => DprViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: whiteColor,
            title: const Text(
              "Dpr View",
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
                                  onTap: () {
                                    showCustomDialog(
                                      context,
                                      data,
                                      token,
                                      userId,
                                    );
                                  },
                                  child: Dismissible(
                                    key: Key(UniqueKey().toString()),
                                    background: Container(
                                      color: Colors.red,
                                      alignment: Alignment.centerRight,
                                      child: const Icon(
                                        Icons.delete,
                                        color: whiteColor,
                                      ),
                                    ),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      if (direction ==
                                          DismissDirection.endToStart) {
                                        model.deleteDpr(
                                          token: token,
                                          userId: userId,
                                          index: index,
                                          id: data.id.toString(),
                                        );
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      width: double.infinity,
                                      height: (_size.height * 0.1) + 5,
                                      child: Card(
                                        // color: greyColor.withOpacity(0.2),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Task ${index + 1} By . Darshan kasundra',
                                                style: const TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0),
                                                child: Text(
                                                  data.dprDescription ??
                                                      'Empty',
                                                  style: const TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
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
                                model.toCategoryView(
                                  userId: userId,
                                  token: token,
                                  projectId: projectId,
                                );
                              },
                              size: _size,
                              color: blackColor,
                              icon: Icons.add,
                              text: 'Add Dpr',
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

  void showCustomDialog(
    BuildContext context,
    DprListModel model,
    int token,
    int userId,
  ) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return EdittingDprView(data: model, token: token, userId: userId);
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
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
