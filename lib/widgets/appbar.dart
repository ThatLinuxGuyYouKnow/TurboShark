import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  const CustomAppBar({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 137, // Standard height
      backgroundColor: Colors.white,
      centerTitle: false, // Left-align title
      title: Column(
        children: [
          Expanded(
            flex: 0,
            child: Row(
              children: [
                Text(
                  appBarTitle,
                  style: GoogleFonts.ubuntu(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      elevation: 0, // Remove shadow
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          color: Colors.black.withOpacity(0.2),
          height: 1,
          thickness: 1,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(137);
}
