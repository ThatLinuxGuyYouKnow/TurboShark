import 'package:uuid/uuid.dart';
import 'package:turbo_shark/enums/downloadState.dart';

class Download {
  final String id;
  final String name;
  double progress;
  Downloadstate state;
  final int size;
  final DateTime date;

  Download({
    required this.size,
    required this.date,
    String? id,
    required this.name,
    this.progress = 0.0,
    this.state = Downloadstate.inProgress,
  }) : id = id ?? const Uuid().v4();
}
