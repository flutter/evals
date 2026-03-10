import 'dart:io';
import 'package:path/path.dart' as p;

String expandHomeDir(String path) {
  if (!path.startsWith('~')) {
    return path;
  }

  String? home;
  if (Platform.isWindows) {
    home = Platform.environment['USERPROFILE'];
  } else {
    home = Platform.environment['HOME'];
  }

  if (home == null) {
    return path; // Cannot expand
  }

  if (path == '~') {
    return home;
  }
  if (path.startsWith('~/')) {
    return p.join(home, path.substring(2));
  }

  return path; // or throw an exception for unsupported formats like ~user
}
