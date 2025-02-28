import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:umbrella_care/Models/models.dart';
import 'package:umbrella_care/core/exceptions/app_exceptions.dart';

class FirebaseAuthService {
  static late final UserCredential userCredential;
  static final db = FirebaseFirestore.instance;

  static Future<void> registerPatient(PatientModel patient) async {
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: patient.email,
        password: patient.password,
      );

      db.collection('patients').doc(userCredential.user!.uid).set({
        'name': patient.name,
        'email': patient.email,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordException('Password too weak');
      } else if (e.code == 'email-already-in-use') {
        throw WeakPasswordException('Account already exists');
      }
    }
  }
}
