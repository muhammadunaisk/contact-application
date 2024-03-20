import 'package:contact_adding/feature/contact/model/contactModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final contactprovider = NotifierProvider<ContactNotifier, List<Contact>>(() {
  return ContactNotifier();
});
final imageProvider = StateProvider<XFile?>((ref) => null);

class ContactNotifier extends Notifier<List<Contact>> {
  @override
  List<Contact> build() {
    return [];
  }

  void addContact(int? index, Contact contact) {
    if (index != null) {
      final update = [...state];
      update[index] = contact;
      state = update;
    } else {
      state = [...state, contact];
    }
  }

  void delete(int index) {
    final dlt = state;
    dlt.removeAt(index);
    state = List.from(dlt);
  }
}
