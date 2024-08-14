
import 'package:flutter/material.dart';
import 'package:flutter_frontend/screens/Drawer/DraweHeader/drawer_header.dart';
import 'package:flutter_frontend/service/auth_service.dart';


class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  // void initState() {
  //   super.initState();
  //   // Fetch the profile picture when the drawer is opened
  //   context.read<ProfilePicBloc>().add(GetImageEvent());y
  
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerProfileHead(),
        ListTile(
          leading: const Icon(Icons.checklist_rtl_rounded),
          title: const Text('Regular Paymnets'),
          onTap: () {
            Navigator.pushNamed(context, '/regular_payments');
          },
        ),
        ListTile(
          leading: const Icon(Icons.currency_rupee_sharp),
          title: const Text('Set Budget'),
          onTap: () {
            Navigator.pushNamed(context, '/budget');
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout_rounded),
          title: const Text('Log Out'),
          onTap: () {
            AuthService().logout(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text('Profile'),
          onTap: () {
            // Handle the tap here
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            // Handle the tap here
            Navigator.pop(context);
          },
        ),
      ],
    ));
  }
}
