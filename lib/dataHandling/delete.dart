import 'package:hive/hive.dart';

Future<void> clearAllHiveData() async {
  try {
    // Close all opened Hive boxes
    await Hive.close();

    // Delete all Hive data from the disk
    await Hive.deleteFromDisk();

    print("All Hive data cleared successfully.");
  } catch (e) {
    print("Error while clearing Hive data: $e");
  }
}
