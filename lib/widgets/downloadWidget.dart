import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turbo_shark/enums/downloadState.dart';
import 'package:turbo_shark/models/download.dart';

class DownloadWidget extends StatelessWidget {
  final Download download;
  const DownloadWidget({Key? key, required this.download}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isCompactMode = constraints.maxWidth < 400;

        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // File type icon
                Icon(
                  _getIconForFileType(download.name),
                  color: Colors.blue.shade100,
                  size: 40,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Filename with truncation
                      Text(
                        download.name,
                        style: GoogleFonts.ubuntu(
                          fontSize: isCompactMode ? 14 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      // Progress indicator
                      LinearProgressIndicator(
                        value: download.progress,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getProgressColor(download.state),
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
                    color: _getStateBackgroundColor(download.state),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    download.state.name.toUpperCase(),
                    style: GoogleFonts.ubuntu(
                      color: _getStateTextColor(download.state),
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
        return Colors.orange;
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
        return Colors.orange.shade50;
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
        return Colors.orange.shade700;
      case Downloadstate.done:
        return Colors.green.shade700;
      case Downloadstate.failed:
        return Colors.red.shade700;
      default:
        return Colors.grey.shade700;
    }
  }
}
