import 'package:flutter/material.dart';
import '../Setting.dart';

class sideMenu extends StatelessWidget {
  const sideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: const Text("John Cena"),
                  accountEmail: const Text("02210200.cst@rub.edu.bt"),
                  currentAccountPicture: ClipOval(
                    child: Image.network(
                      "https://images.pexels.com/photos/3454298/pexels-photo-3454298.jpeg?auto=compress&cs=tinysrgb&w=600",
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.account_box),
                  title: const Text("Your Account"),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Settings"),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Setting(),
                    ));
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.star),
                  title: const Text("Rate Us"),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.favorite),
                  title: const Text("Follow Us"),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Log Out"),
                  onTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: 140,
            child: AppMode(),
          ),
        ],
      ),
    );
  }
}

class AppMode extends StatefulWidget {
  const AppMode({super.key});

  @override
  State<AppMode> createState() => _AppModeState();
}

class _AppModeState extends State<AppMode> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 140,
        color: Color.fromRGBO(191, 208, 240, 0.49),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 25,
          ),
          child: Row(
            children: [
              Text(
                "App Mode",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              Switch(
                value: _switchValue,
                onChanged: (value) {
                  setState(() {
                    _switchValue = value;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
