import 'package:airwaycompanion/Modules/Firebase/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileData {
  String Name = 'Not Set';
  String Mail = 'Not set';
  String MobileNumber = 'Not set';
  DateTime LastLogin = DateTime.now();
  String Address = 'Not set';

  getDetails() async {
    try {
      var auth = await Firebase.firebaseAuthentication
          .signInWithEmailAndPassword(
              email: 'shreyash@gmail.com', password: '123456789');
      //    auth.additionalUserInfo.profile.

      print(auth.credential);
      print(auth.additionalUserInfo);
      print(auth.user);
      var data = await Firebase.firebaseFirestoreInstance
          .collection('users')
          .doc('profiles')
          .get();
      //data.data();
    } catch (e) {
      print('Error Occured');
      print(e.toString());
    }
  }
}
