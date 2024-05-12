import 'package:flutter/material.dart';
import 'package:obsidian/components/drawer_tile.dart';
import 'package:obsidian/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            DrawerHeader(
              child: Icon(
                Icons.account_circle, // Icono de cuenta de usuario
                size: 100, // ajusta el tamaño según sea necesario
                color: Theme.of(context)
                    .iconTheme
                    .color, // Usa el color de los iconos del tema
              ),
            ),

            // note fill
            DrawerTile(
              title: 'Notes',
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            //

            DrawerTile(
              title: 'Settings',
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ));
              },
            ),
          ],
        ));
  }
}
