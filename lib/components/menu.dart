import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Image.asset(
                'lib/images/logo.png',
                height: 300,
              ),
            ),
          ),
          ListTile(
            title: const Text("HOME"),
            onTap: () => {
              Navigator.pushNamed(context, '/home'),
            },
          ),
          ListTile(
            title: const Text("ARTISTAS"),
            onTap: () => {
              Navigator.pushNamed(context, '/artists'),
            },
          )
        ],
      ),
    );
  }
}
