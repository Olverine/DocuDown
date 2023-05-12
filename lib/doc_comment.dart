import 'package:docudown/comment.dart';

final RegExp commentStartPattern = RegExp(r'^\s*\/\*\*');
final RegExp commentBodyPattern = RegExp(r'^\s*\*\s*(.*)');
final RegExp commentEndPattern = RegExp(r'^\s*\*\/');
final RegExp paramCommentPattern = RegExp(r'@param\s([^\s]+)\s(.*)');
final RegExp returnCommentPattern = RegExp(r'@return\s(.*)');

class DDDocComment {
  DDComment description = DDComment("");
  DDComment returnComment = DDComment("");
  Map<String, DDComment> paramComments = <String, DDComment>{};

  late DDComment currentComment;

  DDDocComment() {
    currentComment = description; 
  }

  void addCommentLine(String commentLine) {
    if(paramCommentPattern.hasMatch(commentLine)) {
      final RegExpMatch match = paramCommentPattern.firstMatch(commentLine)!;
      DDComment comment = DDComment("${match.group(2)!}\n");
      currentComment = comment;
      paramComments.putIfAbsent(match.group(1)!, () => comment);
    } 
    else if(returnCommentPattern.hasMatch(commentLine)) {
      final RegExpMatch match = returnCommentPattern.firstMatch(commentLine)!;
      returnComment = DDComment("${match.group(1)!}\n");
      currentComment = returnComment;
    } else {
      currentComment.comment += '>$commentLine';
    }
  }
}

bool isDocCommentStart(String line) {
  return commentStartPattern.hasMatch(line);
}

bool isDocCommentBody(String line) {
  return commentBodyPattern.hasMatch(line);
}

bool isDocCommentEnd(String line) {
  return commentEndPattern.hasMatch(line);
}