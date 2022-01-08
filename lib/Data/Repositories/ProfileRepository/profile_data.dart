import 'package:airwaycompanion/Modules/Firebase/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileData {
  String name = 'Not Set';
  String mail = 'Not set';
  String mobileNumber = 'Not set';
  DateTime lastLogin = DateTime.now();
  String address = 'Not set';

  getDetails() async {
    try {
      var data = await Firebase.firebaseFirestoreInstance
          .collection('users')
          .doc('profiles')
          .get();
    } catch (e) {
      print('Error Occured');
      print(e.toString());
    }
  }
}
