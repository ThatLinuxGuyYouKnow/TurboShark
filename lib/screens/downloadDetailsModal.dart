import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:turbo_shark/logic/downloadManager.dart';
import 'package:turbo_shark/models/downloadProvider.dart';
import 'package:turbo_shark/user_preferences.dart';
import 'package:turbo_shark/widgets/dropdowns.dart';
import 'package:turbo_shark/widgets/textfields.dart';

class DownloadDetailsModal extends StatefulWidget {
  final Function onModalClosePrompted;

  const DownloadDetailsModal({Key? key, required this.onModalClosePrompted})
      : super(key: key);

  @override
  State<DownloadDetailsModal> createState() => _DownloadDetailsModalState();
}

class _DownloadDetailsModalState extends State<DownloadDetailsModal> {
  String selectedPriority = "Normal"; // Default priority
  String? downloadUrl;
  String? downloadPATH;
  String fileName = 'download' + DateTime.now().toString();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final downloadState = Provider.of<DownloadProvider>(context);
    final UserPreferences userPreferences = UserPreferences();

    final isCompactMode = screenWidth < 600;

    return FutureBuilder<bool?>(
      future: userPreferences.getTheme(),
      builder: (context, snapshot) {
        return Container(
          height: screenHeight,
          width: screenWidth,
          color: Colors.black.withOpacity(0.3),
          child: Center(
            child: Container(
              height: 800,
              width: 700,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Close Button
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, right: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () => widget.onModalClosePrompted(),
                      ),
                    ),
                  ),

                  // Header Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Download',
                          style: GoogleFonts.ubuntu(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Enter the details for your new download.',
                          style: GoogleFonts.ubuntu(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Download URL Section
                  _buildSectionTitle('Download URL'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: CustomTextField(
                      prefix: Icons.link,
                      hint: 'Paste your download URL here',
                      textFormString: (String text) {
                        setState(() {
                          downloadUrl = text;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // File Name Section
                  _buildSectionTitle('File Name (Optional)'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: CustomTextField(
                      prefix: Icons.file_copy,
                      hint: 'my-download.mkv',
                      textFormString: (String text) {
                        setState(() {
                          fileName = text;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Download Location Dropdown
                  _buildSectionTitle('Download Location'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: DownloadLocationDropdown(
                      onNewLocationSelected: (String location) {
                        downloadPATH = location;
                        // Handle location selection
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Download Priority Section
                  _buildSectionTitle('Download Priority'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text('High'),
                          value: "High",
                          groupValue: selectedPriority,
                          onChanged: (value) {
                            setState(() {
                              selectedPriority = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Normal'),
                          value: "Normal",
                          groupValue: selectedPriority,
                          onChanged: (value) {
                            setState(() {
                              selectedPriority = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Low'),
                          value: "Low",
                          groupValue: selectedPriority,
                          onChanged: (value) {
                            setState(() {
                              selectedPriority = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Submit Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          downloadState.startDownload(context,
                              downloadUrl ?? '', downloadPATH ?? '' + fileName);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade300,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Start Download',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
      child: Text(
        title,
        style: GoogleFonts.ubuntu(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }
}
