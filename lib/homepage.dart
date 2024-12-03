import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turbo_shark/widgets/customDrawer.dart';
import 'package:turbo_shark/widgets/searchBar.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth >= 400;

        return Scaffold(
          // Remove the AppBar for wide screens to prevent interference with drawer
          appBar: !isWideScreen
              ? AppBar(
                  title: Text(
                    'Downloads',
                    style: GoogleFonts.kanit(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
              if (isWideScreen) CustomDrawer(),

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
                          child: Text(
                            'Downloads',
                            style: GoogleFonts.ubuntu(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
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
