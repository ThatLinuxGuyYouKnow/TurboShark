import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:turbo_shark/enums/downloadState.dart';
import 'package:turbo_shark/models/download.dart';
import 'package:turbo_shark/models/themeState.dart';
import 'package:turbo_shark/user_preferences.dart';

class DownloadWidget extends StatefulWidget {
  final Download download;

  const DownloadWidget({
    Key? key,
    required this.download,
  }) : super(key: key);

  @override
  State<DownloadWidget> createState() => _DownloadWidgetState();
}

class _DownloadWidgetState extends State<DownloadWidget> {
  @override
  Widget build(BuildContext context) {
    final darkModeState = Provider.of<LiveTheme>(context);
    bool isDarkMode = darkModeState.isDarkMode;

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isCompactMode = constraints.maxWidth < 400;

        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.withOpacity(0.4))),
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // File type icon
                Icon(
                  _getIconForFileType(widget.download.name),
                  color: Colors.blue.shade100,
                  size: 40,
                ),
                const SizedBox(width: 22),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Filename with truncation
                      Text(
                        widget.download.name,
                        style: GoogleFonts.ubuntu(
                          fontSize: isCompactMode ? 14 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      // Progress indicator
                      LinearProgressIndicator(
                        value: widget.download.state == Downloadstate.done

                            /// multiplying by 4 is atemporary stopgap till i actually figure out a better way to handle this
                            /// could break once user is able to select number of segments
                            /// TODO: implement better logic for handling progress display, iddeally i should multiply progress by the number of segments
                            ? 100
                            : widget.download.progress * 4,
                        backgroundColor: Colors.grey[50],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDarkMode ? Colors.black : Colors.blue,
                        ),
                        minHeight: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Download state
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStateBackgroundColor(widget.download.state),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.download.state.name.toUpperCase(),
                    style: GoogleFonts.ubuntu(
                      color: _getStateTextColor(widget.download.state),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Determine icon based on file extension
  IconData _getIconForFileType(String filename) {
    final extension = filename.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'zip':
      case 'rar':
        return Icons.folder_zip;
      case 'mp3':
      case 'wav':
        return Icons.music_note;
      case 'mp4':
      case 'avi':
      case 'mkv':
        return Icons.video_file;
      case 'jpg':
      case 'png':
      case 'jpeg':
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  // Color based on download state
  Color _getProgressColor(Downloadstate state) {
    switch (state) {
      case Downloadstate.inProgress:
        return Colors.blue;
      case Downloadstate.done:
        return Colors.green;
      case Downloadstate.failed:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  // State background color
  Color _getStateBackgroundColor(Downloadstate state) {
    switch (state) {
      case Downloadstate.inProgress:
        return Colors.blue.shade50;
      case Downloadstate.done:
        return Colors.green.shade50;
      case Downloadstate.failed:
        return Colors.red.shade50;
      default:
        return Colors.grey.shade50;
    }
  }

  // State text color
  Color _getStateTextColor(Downloadstate state) {
    switch (state) {
      case Downloadstate.inProgress:
        return Colors.blue.shade700;
      case Downloadstate.done:
        return Colors.green.shade700;
      case Downloadstate.failed:
        return Colors.red.shade700;
      default:
        return Colors.grey.shade700;
    }
  }
}
