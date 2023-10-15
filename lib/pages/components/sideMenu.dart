import 'package:flutter/material.dart';

class sideMenu extends StatelessWidget {
  const sideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("John Cena"),
            accountEmail: Text("02210200.cst@rub.edu.bt"),
            currentAccountPicture: ClipOval(
              child: Image.network(
                "https://images.pexels.com/photos/3454298/pexels-photo-3454298.jpeg?auto=compress&cs=tinysrgb&w=600",
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text("Your Account"),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.star),
            title: Text("Rate Us"),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Follow Us"),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Log Out"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
