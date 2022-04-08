import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/view_models/add_project2_view_model.dart';

import '../../app/app.locator.dart';
import '../../services/contact_pick_service.dart';
import '../../utils/color/color_pallets.dart';

class SelectableWidget extends StatefulWidget {
  final ValueChanged<List<Contact>> onChnaged;
  const SelectableWidget({
    Key? key,
    required this.onChnaged,
  }) : super(key: key);

  @override
  State<SelectableWidget> createState() => _SelectableWidgetState();
}

class _SelectableWidgetState extends State<SelectableWidget> {
  bool isSearching = false;
  final _snackbarService = locator<SnackbarService>();
  final _contactService = locator<ContactPickService>();

  List<Contact> listOfContact = [];
  static final List<Color> _colors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.yellow,
    Colors.indigo,
    Colors.brown,
  ];

  List<Contact> selectedContact = [];

  Future<bool?> requestPermission() async {
    bool? isGranted;
    final status = await Permission.contacts.request();
    if (status == PermissionStatus.granted) {
      isGranted = true;
    } else if (status == PermissionStatus.denied) {
      isGranted = false;
    } else if (status == PermissionStatus.permanentlyDenied) {
      isGranted = false;
    }
    return isGranted;
  }

  @override
  void initState() {
    super.initState();
    getContact();
  }

  void selectContact(Contact contact) {
    if (selectedContact.contains(contact)) {
      setState(() {
        selectedContact.removeWhere((element) => element == contact);
      });
    } else {
      setState(() {
        selectedContact.add(contact);
      });
    }
  }

  Future<void> getContact() async {
    isSearching = true;
    bool? per = await requestPermission();
    isSearching = false;
    setState(() {});
    if (per!) {
      final data = (await _contactService.getListOfContact()).toList();
      listOfContact = data;
      setState(() {});
      return;
    } else {
      _snackbarService.registerSnackbarConfig(SnackbarConfig(
        messageColor: whiteColor,
      ));
      _snackbarService.showSnackbar(message: 'Permission denied');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<NewProjectViewModel>.reactive(
      viewModelBuilder: () => NewProjectViewModel(),
      builder: (context, model, child) {
        return Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: isSearching == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      height: _size.height * 0.1 - 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Contacts'),
                          Text('Selected(${selectedContact.length})'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: listOfContact.length,
                        itemBuilder: (context, index) {
                          final data = listOfContact[index];
                          return ListTile(
                            trailing: selectedContact.contains(data)
                                ? const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.check_circle_outline,
                                    color: greyColor,
                                  ),
                            onTap: () {
                              selectContact(data);
                              widget.onChnaged(selectedContact);
                            },
                            leading: CircleAvatar(
                              backgroundColor: _colors[index % _colors.length],
                              child: Text(
                                data.displayName == null
                                    ? ''
                                    : data.displayName!.substring(0, 1),
                              ),
                            ),
                            title: Text(
                              data.displayName ?? 'No name',
                            ),
                            subtitle: Text(
                              data.phones!.isEmpty
                                  ? 'none'
                                  : data.phones?.elementAt(0).value ?? '',
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
