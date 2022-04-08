import 'package:contacts_service/contacts_service.dart';

class ContactPickService {
  Future<List<Contact>> getListOfContact() async {
    List<Contact> contacts =
        (await ContactsService.getContacts(withThumbnails: false));
    // print(contacts);
    return contacts;
  }
}
