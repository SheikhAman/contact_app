import 'package:flutter/material.dart';
import 'package:class_18/pages/contact_details_page.dart';
import 'package:class_18/pages/contact_list_page.dart';
import 'package:class_18/pages/new_contact_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ContactListPage.routeName,
      routes: {
        ContactListPage.routeName: (context) => ContactListPage(),
        ContactDetailsPage.routeName: (context) => ContactDetailsPage(),
        NewContactPage.routeName: (context) => NewContactPage(),
      },
    );
  }
}
