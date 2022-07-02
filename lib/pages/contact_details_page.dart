import 'dart:io';

import 'package:class_18/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName = '/details';
  final contact;

  const ContactDetailsPage({this.contact, Key? key}) : super(key: key);

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  final emailController = TextEditingController();
  final mapController = TextEditingController();
  final webController = TextEditingController();
  bool emailState = false;
  bool mapState = false;
  bool webState = false;

  // @override
  // void didChangeDependencies() {
  //   contact = ModalRoute.of(context)!.settings.arguments as ContactModel;
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact.name),
      ),
      body: ListView(
        children: [
          widget.contact.image == null
              ? Image.asset(
                  'images/person.jpg',
                  width: double.maxFinite,
                  height: 250,
                  fit: BoxFit.cover,
                )
              : Image.file(
                  File(widget.contact.image!),
                  width: double.maxFinite,
                  height: 250,
                  fit: BoxFit.cover,
                ),
          ListTile(
            title: Text(widget.contact.mobile),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: _callPerson,
                  icon: Icon(Icons.call),
                ),
                IconButton(
                  onPressed: _smsContact,
                  icon: Icon(Icons.sms),
                ),
              ],
            ),
          ),
          ListTile(
            title: emailState
                ? TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  )
                : Text(widget.contact.email!.isEmpty ||
                        widget.contact.email == null
                    ? 'Unavailable email'
                    : widget.contact.email!),
            trailing: IconButton(
              onPressed:
                  widget.contact.email!.isEmpty || widget.contact.email == null
                      ? _editEmail
                      : _mailContact,
              icon: emailState
                  ? Icon(Icons.save)
                  : Icon(widget.contact.email!.isEmpty ||
                          widget.contact.email == null
                      ? Icons.edit
                      : Icons.email),
            ),
          ),
          ListTile(
            title: mapState
                ? TextField(
                    controller: mapController,
                    decoration: InputDecoration(
                      hintText: 'Enter your address',
                      prefixIcon: Icon(Icons.map),
                    ),
                  )
                : Text(widget.contact.streetAddress!.isEmpty ||
                        widget.contact.streetAddress == null
                    ? 'Unavailable address'
                    : widget.contact.streetAddress!),
            trailing: IconButton(
              onPressed: widget.contact.streetAddress!.isEmpty ||
                      widget.contact.streetAddress == null
                  ? _editMap
                  : _showMap,
              icon: mapState
                  ? Icon(Icons.save)
                  : Icon(
                      widget.contact.streetAddress!.isEmpty ||
                              widget.contact.streetAddress == null
                          ? Icons.edit
                          : Icons.map,
                    ),
            ),
          ),
          ListTile(
            title: webState
                ? TextField(
                    controller: webController,
                    decoration: InputDecoration(
                      hintText: 'Enter your WebAddress',
                      prefixIcon: Icon(Icons.language),
                    ),
                  )
                : Text(widget.contact.website!.isEmpty ||
                        widget.contact.website == null
                    ? 'Unavailable website'
                    : widget.contact.website!),
            trailing: IconButton(
              onPressed: widget.contact.website!.isEmpty ||
                      widget.contact.website == null
                  ? _editWeb
                  : _showWeb,
              icon: webState
                  ? Icon(Icons.save)
                  : Icon(widget.contact.website!.isEmpty ||
                          widget.contact.website == null
                      ? Icons.edit
                      : Icons.language),
            ),
          ),
        ],
      ),
    );
  }

  _callPerson() async {
    final uri = Uri.parse('tel:${widget.contact.mobile}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Can't launch call";
    }
    ;
  }

  void _smsContact() async {
    final uri = Uri.parse('sms:${widget.contact.mobile}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Can't launch sms";
    }
  }

  void _mailContact() async {
    final uri = Uri.parse(
        'mailto:${widget.contact.email}?subject=Food&body=Aman love\'s food.');
    if (!await launchUrl(uri)) throw 'Could not launch $uri';
    setState(() {});
  }

  void _showMap() async {
    var uriString;

    if (Platform.isAndroid) {
      uriString = 'geo:0,0?q=${widget.contact.streetAddress}';
    } else if (Platform.isIOS) {
      uriString = 'http://maps.apple.com/?q=${widget.contact.streetAddress}';
    } else {
      uriString = 'geo:0,0?q=${widget.contact.streetAddress}';
    }

    final uri = Uri.parse(uriString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Can't launch googleMap";
    }
  }

  void _showWeb() async {
    final uri = Uri.parse('https:${widget.contact.website}');
    if (!await launchUrl(uri)) throw 'Could not launch $uri';
  }

  void _editEmail() {
    setState(() {
      emailState = !emailState;
      widget.contact.email = emailController.text;
    });
  }

  void _editMap() {
    setState(() {
      mapState = !mapState;
      widget.contact.streetAddress = mapController.text;
    });
  }

  void _editWeb() {
    setState(() {
      webState = !webState;
      widget.contact.website = webController.text;
    });
  }
}
