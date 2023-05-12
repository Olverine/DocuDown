
final RegExp parameterPattern = RegExp(r'([a-zA-Z_][a-zA-Z0-9_]*\s+)*(struct\s+)?([a-zA-Z_][a-zA-Z0-9_]*\s+)?([a-zA-Z_*][a-zA-Z0-9_*]*)\s+([a-zA-Z_][a-zA-Z0-9_]*)');

class DDParameter {
  late String dataType;
  late String name;
  String description = "";

  DDParameter.fromString(String input) {
    final RegExpMatch match = parameterPattern.firstMatch(input)!;
    dataType = '${match.group(1)??''} ${match.group(4)??''}';
    name = match.group(5)??'Unknown';
  }

  @override
  String toString() {
    return "#### `$name`\n\t>${description.replaceAll("\n", "\n\t")}\n\n\ttype: `$dataType`";
  }
}

bool isParameter(String input) {
  return parameterPattern.hasMatch(input);
}