import 'package:turbo_shark/enums/downloadState.dart';

class Download {
  final String name;
  double progress;
  Downloadstate state;

  Download({
    required this.name,
    this.progress = 0.0,
    this.state = Downloadstate.inProgress,
  });
}
