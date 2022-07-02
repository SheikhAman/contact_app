import 'dart:io';

import 'package:class_18/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName = '/new_contact';
  const NewContactPage({Key? key}) : super(key: key);

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final webController = TextEditingController();

  String? dob;
  String? imagePath;
  String genderGroupValue = 'Male';
  ImageSource source = ImageSource.camera;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    webController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Conatact'),
        actions: [
          IconButton(
            onPressed: _saveContact,
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            keyboardType: TextInputType.name,
            controller: nameController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
              filled: true,
              labelText: 'Full Name',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: phoneController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.call),
              filled: true,
              labelText: 'Mobile Number',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email),
              filled: true,
              labelText: 'Email Address',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.streetAddress,
            controller: addressController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.my_location),
              filled: true,
              labelText: 'Street Address',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.url,
            controller: webController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.web),
              filled: true,
              labelText: 'Website',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Select Gender'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: 'Male',
                      groupValue: genderGroupValue,
                      onChanged: (value) {
                        setState(() {
                          genderGroupValue = value as String;
                        });
                      },
                    ),
                    Text('Male'),
                    SizedBox(
                      width: 7,
                    ),
                    Radio(
                      value: 'Female',
                      groupValue: genderGroupValue,
                      onChanged: (value) {
                        setState(() {
                          genderGroupValue = value as String;
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: _showDatePickerDialog,
                child: const Text('Select Date of Birth'),
              ),
              Chip(
                label: Text(dob == null ? 'No date chosen' : dob!),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 5,
                child: imagePath == null
                    ? Image.asset(
                        'images/person.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(imagePath!),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      source = ImageSource.camera;
                      _getImage();
                    },
                    label: Text('Capture'),
                    icon: Icon(Icons.camera),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      source = ImageSource.gallery;
                      _getImage();
                    },
                    label: Text('Gallery'),
                    icon: Icon(Icons.photo),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  void _showDatePickerDialog() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1992),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        dob = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  void _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  _saveContact() {
    final contact = ContactModel(
      name: nameController.text,
      mobile: phoneController.text,
      email: emailController.text,
      streetAddress: addressController.text,
      website: webController.text,
      dob: dob,
      image: imagePath,
      gender: genderGroupValue,
    );
    print(contact);
    contactList.add(contact);
    Navigator.pop(
      context,
    );
  }
}
