class PatientModel {
  PatientModel({
    this.uid,
    required this.name,
    this.contact,
    required this.email,
    required this.password,
    this.image,
  });

  final String email;
  final String name;
  final String password;
  final String? contact;
  final String? uid;
  final String? image;
}
