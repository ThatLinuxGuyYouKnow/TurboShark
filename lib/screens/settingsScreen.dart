import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turbo_shark/widgets/appbar.dart';
import 'package:turbo_shark/widgets/dropdowns.dart';
import 'package:turbo_shark/widgets/switches.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light grey background
      appBar: CustomAppbar(
        textContent: 'Settings',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Default Download Path Section
              _buildSectionTitle('Default Download PATH'),
              const SizedBox(height: 10),
              DownloadLocationDropdown(
                onNewLocationSelected: (location) {
                  print('New location: $location');
                },
              ),
              const SizedBox(height: 30),

              // Max Concurrent Downloads Section
              _buildSectionTitle('Max Concurrent Downloads'),
              const SizedBox(height: 10),
              ConcurrentDownloadsSelector(),
              const SizedBox(height: 30),

              // Default Download Priority Section
              _buildSectionTitle('Default Download Priority'),
              const SizedBox(height: 10),
              DownloadPrioritySelector(),
              const SizedBox(height: 50),

              // Auto Resume Downloads Section

              AutoResumeSwitch(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.ubuntu(
        fontWeight: FontWeight.w700,
        fontSize: 17,
        color: Colors.black.withOpacity(0.8),
      ),
    );
  }
}
