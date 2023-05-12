import 'package:docudown/doc_comment.dart';
import 'package:docudown/function.dart';
import 'package:docudown/parameter.dart';
import 'package:docudown/struct.dart';

class CodeScanner {
  List<DDStruct> structs = [];
  List<DDParameter> globalParameters = [];
  List<DDFunction> globalFunctions = [];
  DDDocComment? relevantDocComment;
  int blockLevel = 0;

  void scanLine(String line) {
    if(isDocCommentStart(line)) {
      relevantDocComment = DDDocComment();
    }
    if(!isDocCommentEnd(line) && isDocCommentBody(line)) {
      RegExpMatch match = commentBodyPattern.firstMatch(line)!;
      relevantDocComment!.addCommentLine('${match.group(1)??'\n\n'}\n');
    }
    if(isFunction(line)) {
      DDDocComment comment = (relevantDocComment??DDDocComment());
      DDFunction function = DDFunction.fromString(line, comment.paramComments);
      function.description = comment.description;
      function.returnComment = comment.returnComment;
      globalFunctions.add(function);
    }
    else if(isStruct(line)) {
      DDDocComment comment = (relevantDocComment??DDDocComment());
      RegExpMatch match = structPattern.firstMatch(line)!;
      DDStruct struct = DDStruct(match.group(1)!.trim(), comment.description);
      structs.add(struct);
    }
  }

  String getMarkDown() {
    String result = "";
    if(structs.isNotEmpty) {
      result += getMarkDownStructs();
    }
    if(globalFunctions.isNotEmpty) {
      result += getMarkDownFunctions();
    }
    return result;
  }

  String getMarkDownStructs() {
    String result = "## Structs\n";
    for(DDStruct struct in structs) {
      result += '${struct.toString()}\n---\n';
    }
    return result;
  }

  String getMarkDownFunctions() {
    String result = "## Functions\n";
    for(DDFunction function in globalFunctions) {
      result += '${function.toString()}\n---\n';
    }
    return result;
  }
}