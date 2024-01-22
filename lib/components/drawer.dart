import "package:flutter/material.dart";
import "package:notes_app/components/drawer_tile.dart";
import "package:notes_app/pages/settings_page.dart";

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(80.0),
            child: SizedBox(
              child: Icon(
                Icons.note,
                size: 50.0,
              ),
            ),
          ),
          DrawerTile(
            leading: const Icon(Icons.home),
            title: "Home",
            onTap: () => Navigator.pop(context),
          ),
          DrawerTile(
            leading: const Icon(Icons.settings),
            title: "Settings",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
          )
        ],
      ),
    );
  }
}
