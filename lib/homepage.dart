import 'package:flutter/material.dart';
import 'package:turbo_shark/widgets/customDrawer.dart';
import 'package:turbo_shark/widgets/searchBar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth >= 700;

        return Scaffold(
          // Remove the AppBar for wide screens to prevent interference with drawer
          appBar: !isWideScreen
              ? AppBar(
                  title: Searchbar(
                    constraints: constraints,
                  ),
                  // Add a custom drawer button
                  leading: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                  ),
                )
              : null,

          // Use a custom body to handle drawer positioning
          body: Row(
            children: [
              // Permanently show drawer on wide screens
              if (isWideScreen)
                const SizedBox(
                  width: 250, // Adjust width as needed
                  child: CustomDrawer(),
                ),

              // Main content expanded
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      // Add searchbar for wide screens
                      if (isWideScreen)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Searchbar(constraints: constraints),
                        ),
                      Expanded(
                        child: Center(
                          child: Text('Main Content'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Drawer for narrow screens
          drawer: !isWideScreen ? CustomDrawer() : null,
        );
      },
    );
  }
}
