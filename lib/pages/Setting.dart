import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              "GENERAL",
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
            contentPadding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title: Text(
              "Notifications",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {},
            trailing: Icon(
              Icons.notifications,
              color: Color.fromRGBO(0, 128, 255, 0.54),
            ),
            contentPadding: EdgeInsets.only(left: 15.0, right: 15.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title: Text(
              "Sound",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {},
            trailing: Icon(
              Icons.volume_mute_rounded,
              color: Color.fromRGBO(0, 128, 255, 0.54),
            ),
            contentPadding: EdgeInsets.only(left: 15.0, right: 15.0),
          ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            title: Text(
              "EXTRA",
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
            contentPadding: EdgeInsets.only(left: 15.0, right: 15.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title: Text(
              "Help & FAQ",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {},
            trailing: Icon(
              Icons.help,
              color: Color.fromRGBO(0, 128, 255, 0.54),
            ),
            contentPadding: EdgeInsets.only(left: 15.0, right: 15.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title: Text(
              "Contact Us",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {},
            trailing: Icon(
              Icons.call,
              color: Color.fromRGBO(0, 128, 255, 0.54),
            ),
            contentPadding: EdgeInsets.only(left: 15.0, right: 15.0),
          ),
        ],
      ),
    );
  }
}
