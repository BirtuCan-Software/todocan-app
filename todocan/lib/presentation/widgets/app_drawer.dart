import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.edit_document,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                    shadows: [
                      Shadow(
                        blurRadius: 3,
                        offset: Offset(0, 5),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "TodoCan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.star,
              color: Theme.of(context).colorScheme.primary,
            ),
            trailing: Switch(
              value: false,
              activeColor: Theme.of(context).colorScheme.secondary,
              thumbColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.primary,
              ),
              onChanged: (val) {},
            ),
            title: Text(
              "BirtuCan Mode",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          const Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "TodoCan © 2025",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(
                "Version 1.0.0",
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
