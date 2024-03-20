import 'package:contact_adding/feature/contact/controller/provider.dart';
import 'package:contact_adding/feature/contact/model/contactModel.dart';
import 'package:contact_adding/feature/contact/view/add_page.dart';
import 'package:contact_adding/feature/contact/view/editdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Contact> contacts = ref.watch(contactprovider);
    return Scaffold(
      appBar: AppBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Color.fromARGB(197, 230, 225, 225),
          leading: Icon(Icons.search),
          title: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search contact and places",
            ),
          ),
          actions: [
            Icon(Icons.mic),
            Icon(Icons.more_vert_outlined),
            Padding(padding: EdgeInsets.only(right: 20))
          ]),
      body: contacts.isEmpty
          ? Center(
              child: Text("add contact"),
            )
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddPage(
                                      nameText: contacts[index].name,
                                      phoneText: contacts[index].phone,
                                      isEdit: true,
                                      index: index,
                                    )));
                      },
                      leading: CircleAvatar(
                        backgroundImage: contacts[index].imagefile == null
                            ? null
                            : FileImage(contacts[index].imagefile!),
                        child: contacts[index].imagefile == null
                            ? Icon(Icons.person)
                            : null,
                        backgroundColor: Colors.black,
                      ),
                      title: Text(contacts[index].name),
                      subtitle: Text(contacts[index].phone.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton.outlined(
                              onPressed: () {
                                showAlertedit(context);
                              },
                              icon: Icon(Icons.edit_calendar)),
                          Padding(padding: EdgeInsets.only(left: 13)),
                          IconButton.filledTonal(
                              hoverColor: Colors.grey,
                              onPressed: () {
                                ref
                                    .read(contactprovider.notifier)
                                    .delete(index);
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      )),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPage(),
              ));
        },
        hoverColor: Colors.white,
        backgroundColor: Colors.grey,
        mouseCursor: SystemMouseCursors.click,
        child: Icon(Icons.add),
      ),
    );
  }
}
