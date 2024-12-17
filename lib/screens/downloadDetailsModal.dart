import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:turbo_shark/models/downloadProvider.dart';
import 'package:turbo_shark/models/themeState.dart';
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
  String? downloadUrl;
  String? downloadPATH;
  String fileName = 'download${DateTime.now()}';
  int concurrentDownloadCount = 4;
  getUserPref() async {
    concurrentDownloadCount =
        await userPreferences.getUserPreferredConcurrentDownloads();
    downloadPATH = await userPreferences.getUserPreferredDownloadLocation() ??
        getDownloadsDirectory()
            .toString(); // if is null, default to the users download directory
    //TODO: Fix this to use the state version rather than the local storage version
    setState(() {});
  }

  final UserPreferences userPreferences = UserPreferences();
  @override
  @override
  Widget build(BuildContext context) {
    getUserPref();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final downloadState = Provider.of<DownloadProvider>(context);
    final themeState = Provider.of<LiveTheme>(context);

    return Container(
      height: screenHeight,
      width: screenWidth,
      color: Colors.black.withOpacity(0.3),
      child: Center(
        child: Container(
          height: 720,
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
                  },
                  locationChangesArePermanent: false,
                ),
              ),

              const SizedBox(height: 20),
              _buildSectionTitle('Number of threads'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: ConcurrentDownloadsSelector(
                  isSelectionChangePermanent: false,
                  onConcDownloadCountChanged: (value) {},
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      downloadState.startDownload(
                        segmentCount: concurrentDownloadCount,
                        context: context,
                        url: downloadUrl ?? '',
                        savePath: downloadPATH ??
                            getDownloadsDirectory().toString() + '/' + fileName,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeState.isDarkMode
                          ? Colors.black
                          : Colors.blue.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Start Download',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
