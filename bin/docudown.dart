import 'dart:io';

import 'package:docudown/code_scanner.dart';

Future<void> main(List<String> arguments) async {
  File outputFile = await File(arguments[1]).create(recursive: true);

  File(arguments[0]).readAsString().then((String contents) {
    
    CodeScanner scanner = CodeScanner();
    final List<String> lines = contents.split("\n");
    for(String line in lines) {
      scanner.scanLine(line);
    }

    final String markdown = scanner.getMarkDown();
    print(markdown);

    outputFile.writeAsString(markdown);
  });
}
