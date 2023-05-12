import 'package:docudown/comment.dart';

final RegExp structPattern = RegExp(r'^\s*struct\s(.*)\s*[{|$]');

class DDStruct {
  final String name;
  final DDComment comment;

  DDStruct(this.name, this.comment);

  @override
  String toString() {
    String result = '### `$name`\n$comment\n\n';
    return result;
  }
}

bool isStruct(String line) {
  return structPattern.hasMatch(line);
}