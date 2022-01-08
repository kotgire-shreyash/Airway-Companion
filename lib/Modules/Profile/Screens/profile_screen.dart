import 'package:airwaycompanion/Data/Repositories/ProfileRepository/profile_data.dart';
import 'package:google_fonts/google_fonts.dart';
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
    super.initState();
    _profileData.getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: backButton(),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _profilePic(),
                  const SizedBox(
                    width: 20,
                  ),
                  _headerDetails(),
                ],
              ),
              const SizedBox(height: 10),
              _detailsBody(),
            ],
          ),
        ),
      ),
    );
  }

  _headerDetails() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 23),
          alignment: Alignment.centerRight,
          // height: 35,
          child: Text(
            _profileData.name,
            style: TextStyle(
              fontFamily:
                  GoogleFonts.lato(fontWeight: FontWeight.w900).fontFamily,
              fontSize: 25,
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 23),
          alignment: Alignment.centerRight,
          height: 25,
          child: Text(
            _profileData.mail,
            style: TextStyle(
              fontFamily:
                  GoogleFonts.lato(fontWeight: FontWeight.w800).fontFamily,
              fontSize: 15,
              color: Colors.grey.shade600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  _profilePic() {
    return Container(
      height: 130,
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        height: 120,
        width: 120,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
            child: Image.asset(
          "assets/images/user.jpg",
          fit: BoxFit.cover,
          height: 80,
          width: 80,
        )),
      ),
    );
  }

  _detailsBody() {
    return Container(
      height: MediaQuery.of(context).size.height - 280,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
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
              subtitle: Text(_profileData.name),
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
              subtitle: Text(_profileData.mail),
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
              subtitle: Text(_profileData.mobileNumber),
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
              subtitle: Text(_profileData.lastLogin.toLocal().toString()),
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
              subtitle: Text(_profileData.address),
            ),
          ),
          const SizedBox(
            height: 20,
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
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }

  editButton() {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 100),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _profileData;
          });
        },
        child: Text('Edit Details'),
        style: TextButton.styleFrom(fixedSize: const Size.fromWidth(100)),
      ),
    );
  }
}
