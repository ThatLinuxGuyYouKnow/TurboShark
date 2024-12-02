import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: constraints.maxWidth < 600
              ? AppBar(
                  title: Text('Your App'),
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
          body: Row(
            children: [
              // Conditionally render drawer based on screen width
              if (constraints.maxWidth >= 600)
                SizedBox(
                  width: 250, // Fixed drawer width
                  child: Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        const DrawerHeader(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Text('Drawer Header'),
                        ),
                        ListTile(
                          title: const Text('Item 1'),
                          onTap: () {
                            // Handle item 1 tap
                          },
                        ),
                        ListTile(
                          title: const Text('Item 2'),
                          onTap: () {
                            // Handle item 2 tap
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              // Main content
              Expanded(
                child: Container(
                  color: Colors.blueAccent.withOpacity(0.1),
                  child: Center(
                    child: Text('Main Content'),
                  ),
                ),
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {
                    // Handle item 1 tap
                  },
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {
                    // Handle item 2 tap
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
