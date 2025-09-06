import 'comment.dart';

final RegExp classPattern = RegExp(r'^\s*class\s+[A-Za-z_]\w*\s*[:{]?');

class DDClass {
  final String name;
  final String superClass;
  final DDComment comment;

  DDClass(this.name, this.superClass, this.comment);

  @override
  String toString() {
    String result = '# `$name`\n$comment\n\n';
    return result;
  }
}