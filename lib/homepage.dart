import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turbo_shark/screens/downloadsScreen.dart';
import 'package:turbo_shark/widgets/customDrawer.dart';
import 'package:turbo_shark/widgets/searchBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen =
            constraints.maxWidth >= 700; // Increased breakpoint

        return Scaffold(
          // Remove the AppBar for wide screens
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
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                  ),
                )
              : null,

          body: isWideScreen
              ? Row(
                  children: [
                    // Permanent drawer on wide screens
                    const SizedBox(
                      child: CustomDrawer(),
                    ),
                    // Expanded main content
                    Expanded(
                      child: DownloadScreen(),
                    ),
                  ],
                )
              : DownloadScreen(), // Full screen on narrow screens

          // Slide-out drawer for narrow screens
          drawer: !isWideScreen ? const CustomDrawer() : null,
        );
      },
    );
  }
}
