import 'package:class_18/models/contact_model.dart';
import 'package:class_18/pages/contact_details_page.dart';
import 'package:class_18/pages/new_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class ContactListPage extends StatefulWidget {
  static const String routeName = '/';
  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    contactList[0].name;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),
      body: ListView.builder(
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          final contact = contactList[index];
          return OpenContainer(
            transitionDuration: Duration(seconds: 1),
            closedBuilder: (ctx, openContainer()) {
              return Card(
                elevation: 8,
                child: ListTile(
                  title: Text(contact.name),
                  onTap: () {
                    openContainer();
                  },
                  leading: CircleAvatar(
                    child: Text(contact.name.substring(0, 2)),
                  ),
                ),
              );
            },
            openBuilder: (ctx, _) {
              return ContactDetailsPage(
                contact: contact,
              );
            },
          );
        },
      ),
      floatingActionButton: OpenContainer(
          transitionType: ContainerTransitionType.fadeThrough,
          transitionDuration: Duration(milliseconds: 700),
          closedBuilder: ((context, action()) {
            return FloatingActionButton(
              onPressed: () async {
                await action();
                setState(
                  () {},
                );
              },
              child: const Icon(Icons.add),
            );
          }),
          openBuilder: (context, action) {
            return NewContactPage();
          }),
    );
  }
}
