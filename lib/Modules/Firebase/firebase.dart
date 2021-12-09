import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firebase {
  static final FirebaseAuth firebaseAuthentication = FirebaseAuth.instance;
  static final FirebaseFirestore firebaseFirestoreInstance =
      FirebaseFirestore.instance;
}
