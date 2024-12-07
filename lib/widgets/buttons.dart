import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:turbo_shark/models/downloadProvider.dart';
import 'package:turbo_shark/user_preferences.dart';

class DownloadPromptButton extends StatelessWidget {
  final Function onNewDownloadPressed;

  DownloadPromptButton({
    Key? key,
    required this.onNewDownloadPressed,
  }) : super(key: key);
  final UserPreferences userPreferences = UserPreferences();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Adjust button size based on screen width
        double buttonWidth = constraints.maxWidth > 600 ? 200 : 150;
        double fontSize = constraints.maxWidth > 600 ? 15 : 12;

        return FutureBuilder(
            future: userPreferences.getTheme(),
            builder: (BuildContext, snapshot) {
              return GestureDetector(
                onTap: () => onNewDownloadPressed(),
                child: Container(
                  height: 50,
                  width: buttonWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade300,
                        Colors.blue.shade400,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade200.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'New Download',
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: fontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
