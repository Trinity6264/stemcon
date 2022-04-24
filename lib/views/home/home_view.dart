import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stemcon/animations/dashboard_effect.dart';
import 'package:stemcon/shared/text_input_decor.dart';
import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/view_models/home_view_model.dart';
import 'package:stemcon/views/home/home_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'search'),
])
class HomeView extends StatelessWidget with $HomeView {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onDispose: (model) {
        disposeForm();
      },
      onModelReady: (model) async {
        await model.reload();
        await model.loadData(
          userId: model.userId!,
          token: model.authenticationToken!.toString(),
        );
        print(model.userId!);
        print(model.authenticationToken!.toString());
      },
      builder: (context, model, child) {
        final _textSize = MediaQuery.of(context).size;
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              model.toAddProjectView(CheckingState.adding);
            },
            child: const Icon(Icons.add),
          ),
          appBar: model.isSearch
              ? AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: whiteColor,
                  elevation: 0.0,
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: textInputDecor.copyWith(
                            hintText: 'Search...',
                            enabled: true,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: whiteColor,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: whiteColor,
                              ),
                            ),
                          ),
                          controller: searchController,
                          focusNode: searchFocusNode,
                          onChanged: (value) {
                            model.searchDatas(
                              userId: model.userId!,
                              token: model.authenticationToken!.toString(),
                              value: value,
                            );
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          model.changedToSerach();
                          searchController.clear();
                          model.loadData(
                            userId: model.userId!,
                            token: model.authenticationToken!.toString(),
                          );
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                )
              : AppBar(
                  automaticallyImplyLeading: false,
                  title: Row(
                    children: [
                      Image.asset('assets/logo/roundlogo.jpg', height: 40),
                      const SizedBox(width: 5),
                      Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'STEMCON',
                          style: TextStyle(
                            color: blackColor,
                            fontSize: (_textSize.width * 0.1) / 1.8,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                  backgroundColor: whiteColor,
                  elevation: 0,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search, color: blackColor),
                      onPressed: () {
                        model.changedToSerach();

                        searchFocusNode.requestFocus();
                      },
                    ),
                    PopupMenuButton(
                        icon: const Icon(Icons.more_vert, color: blackColor),
                        enableFeedback: true,
                        onSelected: (val) {
                          if (val == 2) {
                            model.askLogoutPermission();
                          } else {
                            model.toProfileView();
                          }
                        },
                        itemBuilder: (context) => [
                              const PopupMenuItem(
                                child: Text("Profile"),
                                value: 1,
                              ),
                              const PopupMenuItem(
                                child: Text("Sign-Out"),
                                value: 2,
                              )
                            ]),
                  ],
                ),
          backgroundColor: whiteColor,
          body: RefreshIndicator(
            onRefresh: () {
              model.reload();
              return model.loadData(
                userId: model.userId!,
                token: model.authenticationToken!.toString(),
              );
            },
            child: model.isBusy
                ? const DashboardEffect()
                : model.datas.isEmpty && !model.isBusy
                    ? Center(
                        child: Text(
                          model.errorMessage,
                          style: const TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: model.datas.length,
                        itemBuilder: (context, index) {
                          final data = model.datas[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionPanelList(
                              expansionCallback: (i, isOpen) {
                                model.openContainer(index);
                              },
                              animationDuration: const Duration(seconds: 1),
                              dividerColor: Colors.teal,
                              elevation: 2,
                              children: [
                                ExpansionPanel(
                                  headerBuilder: (
                                    BuildContext context,
                                    bool isExpanded,
                                  ) {
                                    return GestureDetector(
                                      onTap: () {
                                        model.toProjectDescription(data);
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                              16,
                                              8,
                                              8,
                                              8,
                                            ),
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'http://stemcon.likeview.in${data.projectPhotoPath}',
                                                fit: BoxFit.cover,
                                                placeholder: (context, value) {
                                                  return const PictureEffect();
                                                },
                                                errorWidget: (_, __, ___) {
                                                  return Container(
                                                    width: 70,
                                                    height: 70,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10.0,
                                                      ),
                                                      image:
                                                          const DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                          'assets/logo/roundlogo.jpg',
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image:
                                                      CachedNetworkImageProvider(
                                                    'http://stemcon.likeview.in${data.projectPhotoPath}',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.projectName ?? 'Name',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  'PMC ${data.projectCode ?? '123'}',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  data.projectAddress ?? '',
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  body: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Deadline",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  data.projectEndDate ?? '',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Time Zone ",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  data.projectTimezone ??
                                                      'India',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Unit",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  data.projectUnit ?? '5',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Man Hour   ",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${data.projectManHour} Hr",
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: OutlinedButton.icon(
                                                onPressed: () {
                                                  // todo: edit
                                                  model.toAddProjectView(
                                                    CheckingState.editting,
                                                    id: data.id,
                                                    projectEnd:
                                                        data.projectEndDate,
                                                    projectName:
                                                        data.projectName,
                                                    projectPhotoPath:
                                                        data.projectPhotoPath,
                                                    projectStart:
                                                        data.projectStartDate,
                                                    projectAddress:
                                                        data.projectAddress,
                                                    projectAdmin:
                                                        data.projectAdmin,
                                                    projectCode:
                                                        data.projectCode,
                                                    projectEndTime:
                                                        data.projectEndDate,
                                                    projectKeyPoint:
                                                        data.projectKeyPoint,
                                                    projectManHour:
                                                        data.projectManHour,
                                                    projectPurpose:
                                                        data.projectPurpose,
                                                    projectStartTime:
                                                        data.projectStartDate,
                                                    projectStatus:
                                                        data.projectStatus,
                                                    projectUnit:
                                                        data.projectUnit,
                                                    projectTimeZone:
                                                        data.projectTimezone,
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.edit,
                                                  size: 18,
                                                  color: Colors.black,
                                                ),
                                                label: const Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                style: OutlinedButton.styleFrom(
                                                  primary: Colors.black,
                                                  // backgroundColor: Colors.amber,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          25, 12, 25, 12),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      8.0,
                                                    ),
                                                  ),
                                                  // side: BorderSide(width: 2, color: Colors.green),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: OutlinedButton.icon(
                                                onPressed: () {
                                                  model.askDeletetPermission(
                                                    data.id.toString(),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  size: 18,
                                                  color: Colors.redAccent,
                                                ),
                                                label: const Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                    color: Colors.redAccent,
                                                  ),
                                                ),
                                                style: OutlinedButton.styleFrom(
                                                  primary: Colors.black,
                                                  // backgroundColor: Colors.amber,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                    25,
                                                    12,
                                                    25,
                                                    12,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      8.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  isExpanded: model.index == index,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
        );
      },
    );
  }
}
