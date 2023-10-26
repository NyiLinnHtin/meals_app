import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String indentifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: DrawerHeader(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.fastfood,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 18),
                  Text(
                    "Cooking Up!",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
          ),
          ListTileDrawer(
            icon: Icons.restaurant,
            text: "Meals",
            onSelectScreen: onSelectScreen,
          ),
          ListTileDrawer(
            icon: Icons.settings,
            text: "Filters",
            onSelectScreen: onSelectScreen,
          ),
        ],
      ),
    );
  }
}

class ListTileDrawer extends StatelessWidget {
  const ListTileDrawer({
    super.key,
    required this.icon,
    required this.text,
    required this.onSelectScreen,
  });

  final IconData icon;
  final String text;
  final void Function(String indentifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 24,
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      onTap: () {
        onSelectScreen(text);
      },
    );
  }
}
