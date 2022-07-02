class ContactModel {
  int? id;
  String name;
  String mobile;
  String? email;
  String? streetAddress;
  String? dob;
  String? image;
  String? gender;
  String? website;

// dob means date of birth

  ContactModel(
      {this.id,
      required this.name,
      required this.mobile,
      this.email,
      this.streetAddress,
      this.dob,
      this.image,
      this.gender,
      this.website})
      : assert(name.length >= 2);

  // @override
  // String toString() {
  //   return 'ContactModel(image:  $image,gender: $gender, website: $website,name: $name, mobile: $mobile,dob: $dob,id:$id, email: $email, streetAddress: $streetAddress,)';
  // }
}

final contactList = <ContactModel>[
  ContactModel(
      id: 1,
      name: 'Leonel Messi',
      mobile: '01518964156',
      email: 'lm@gmail.com',
      streetAddress: 'Mirpur, Dhaka',
      gender: 'Male',
      website: 'www.flutter.dev',
      dob: '24/06/1985'),
  ContactModel(
      id: 2,
      name: 'Christiano Ronaldo',
      mobile: '01518915615',
      email: 'ronaldo@gmail.com',
      streetAddress: 'Mirpur2, Dhaka',
      gender: 'Male',
      website: 'www.google.dev',
      dob: '24/06/1980'),
];
