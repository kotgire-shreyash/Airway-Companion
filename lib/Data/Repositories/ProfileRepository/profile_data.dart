import 'package:airwaycompanion/Modules/Firebase/firebase.dart';

// User Profile Data
class ProfileData {
  String name = 'Not-Set';
  String mail = 'Not-set';
  String mobileNumber = 'Not-set';
  DateTime lastLogin = DateTime.now();
  String address = 'Not-set';
  String username = 'Not-set';

  getDetails() async {
    try {
      var _data = await Firebase.firebaseFirestoreInstance
          .collection("users")
          .doc("profiles")
          .collection(
              Firebase.firebaseAuthentication.currentUser!.email.toString())
          .doc(Firebase.firebaseAuthentication.currentUser!.uid)
          .get();
      var object = _data.data();

      if (object!.isNotEmpty) {
        name = object['fullname'];
        mail = object['mail'];
        mobileNumber = object['mobile'];
        address = object['address'];
        username = object['username'];
        lastLogin = Firebase
            .firebaseAuthentication.currentUser!.metadata.lastSignInTime!;
      }
    } catch (e) {
      rethrow;
    }
  }
}
