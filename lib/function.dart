import 'package:docudown/comment.dart';
import 'package:docudown/parameter.dart';

final RegExp functionPattern = RegExp(r'^([a-zA-Z_][a-zA-Z0-9_]*\s+)+([a-zA-Z_][a-zA-Z0-9_]*)\((.*)\);');

class DDFunction {
  late String returnType;
  late String name;
  late List<DDParameter> arguments;
  DDComment description = DDComment("");
  DDComment returnComment = DDComment("");

  DDFunction.fromString(String input, Map<String, DDComment> argumentComments) {
    final RegExpMatch match = functionPattern.firstMatch(input)!;
    returnType = match.group(1)!;
    name = match.group(2)!;
    String argumentsStr = match.group(3)!;
    List<String> argumentsList = argumentsStr.split(",");
    arguments = [];
    for(String argument in argumentsList) {
      if(isParameter(argument)) {
        DDParameter param = DDParameter.fromString(argument);
        param.description = (argumentComments[param.name]??DDComment("")).comment;
        arguments.add(param);
      }
    }
  }

  @override
  String toString() {
    String result = '### `$name`\n$description\n\nreturns:  `$returnType`\n>$returnComment\n\n';
    if(arguments.isNotEmpty) {
      result += 'Arguments:\n\n';
      for(DDParameter argument in arguments) {
        result += " - $argument\n";
      }
    }
    return result;
  }

}

bool isFunction(String line) {
  return functionPattern.hasMatch(line);
}