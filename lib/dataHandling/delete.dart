import 'package:hive/hive.dart';
import 'package:turbo_shark/models/download_history.dart';

Future<void> clearAllHiveData() async {
  try {
    final box = Hive.box<DownloadHistory>('downloadHistory');

    box.clear();
    print("All Hive data cleared successfully.");
  } catch (e) {
    print("Error while clearing Hive data: $e");
  }
}
