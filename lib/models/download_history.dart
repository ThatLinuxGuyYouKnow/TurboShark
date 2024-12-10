import 'package:hive/hive.dart';

part 'download_history.g.dart';

@HiveType(typeId: 1)
class DownloadHistory {
  @HiveField(0)
  final String id; // Unique identifier
  @HiveField(1)
  final String fileName; // Name of the file
  @HiveField(2)
  final String filePath; // Local path of the file
  @HiveField(3)
  final double progress; // Progress (0.0 to 1.0)
  @HiveField(4)
  final String state; // Download state ("inProgress", "completed", etc.)
  @HiveField(5)
  final int size;
  @HiveField(6)
  final DateTime time;

  DownloadHistory({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.progress,
    required this.state,
    required this.size,
    required this.time,
  });
}
