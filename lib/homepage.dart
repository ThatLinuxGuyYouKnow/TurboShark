import 'package:flutter/material.dart';
import 'package:turbo_shark/widgets/customDrawer.dart';

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
                if (constraints.maxWidth >= 700) CustomDrawer(),
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
            drawer: CustomDrawer());
      },
    );
  }
}
