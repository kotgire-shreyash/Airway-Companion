import 'package:airwaycompanion/Data/Repositories/ProfileRepository/profile_data.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileData _profileData = ProfileData();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileData.getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            backgroundImage(),
            detailsBody(),
            profilePic(),
            backButton(),
          ],
        ),
      ),
    );
  }

  backgroundImage() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background_image.jpg'),
              fit: BoxFit.cover)),
    );
  }

  profilePic() {
    return Container(
      width: 140.0,
      height: 140.0,
      margin: EdgeInsets.only(top: 125, left: 130),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://th.bing.com/th/id/OIP.-DTmchXt8KxCU_hCF3i6JgHaH6?w=177&h=189&c=7&r=0&o=5&dpr=1.25&pid=1.7'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(80.0),
        border: Border.all(
          color: Colors.white54,
          width: 10.0,
        ),
      ),
    );
  }

  detailsBody() {
    return Container(
      margin: EdgeInsets.only(top: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Card(
            elevation: 0,
            child: ListTile(
              leading: Icon(
                Icons.supervisor_account,
                size: 35,
                color: Colors.blueGrey[800],
              ),
              title: Text('Name',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    // fontFamily: 'Spectral',
                    // color: Colors.black,
                    // // fontSize: 28.0,
                    // fontWeight: FontWeight.w700,
                  )),
              subtitle: Text(_profileData.Name),
            ),
          ),
          Card(
            elevation: 0,
            child: ListTile(
              leading: Icon(
                Icons.mail_outline,
                size: 35,
                color: Colors.blueGrey[800],
              ),
              title: Text('Mail',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  )),
              subtitle: Text(_profileData.Mail),
            ),
          ),
          Card(
            elevation: 0,
            child: ListTile(
              leading: Icon(
                Icons.phonelink_ring,
                size: 35,
                color: Colors.blueGrey[800],
              ),
              title: Text('Mobile Number',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  )),
              subtitle: Text(_profileData.MobileNumber),
            ),
          ),
          Card(
            elevation: 0,
            child: ListTile(
              leading: Icon(
                Icons.timer,
                size: 35,
                color: Colors.blueGrey[800],
              ),
              title: Text('Last login',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  )),
              subtitle: Text(_profileData.LastLogin.toLocal().toString()),
            ),
          ),
          Card(
            elevation: 0,
            child: ListTile(
              leading: Icon(
                Icons.home_sharp,
                size: 35,
                color: Colors.blueGrey[800],
              ),
              title: Text('Address',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  )),
              subtitle: Text(_profileData.Address),
            ),
          ),
          editButton(),
        ],
      ),
    );
  }

  backButton() {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
    );
  }

  editButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(onPressed: () {}, child: Text('Edit Details')),
    );
  }
}
