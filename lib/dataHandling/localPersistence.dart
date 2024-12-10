import 'package:hive/hive.dart';
import 'package:turbo_shark/models/download_history.dart';

class DownloadRepository {
  static const String _boxName = 'downloadHistory';

  // Open the box
  Future<Box<DownloadHistory>> _openBox() async {
    return await Hive.openBox<DownloadHistory>(_boxName);
  }

  // Add a new download
  Future<void> addDownload(DownloadHistory download) async {
    final box = await _openBox();
    await box.put(download.id, download);
  }

  // Get all downloads
  Future<List<DownloadHistory>> getAllDownloads() async {
    final box = await _openBox();
    return box.values.toList();
  }

  // Update download progress and state
  Future<void> updateDownload(
      String id, double progress, String state, size, time) async {
    final box = await _openBox();
    final download = box.get(id);
    if (download != null) {
      final updatedDownload = DownloadHistory(
        id: download.id,
        fileName: download.fileName,
        filePath: download.filePath,
        progress: progress,
        state: state,
        size: size,
        time: time,
      );
      await box.put(id, updatedDownload);
    }
  }

  // Delete a download
  Future<void> deleteDownload(String id) async {
    final box = await _openBox();
    await box.delete(id);
  }
}
