import 'dart:io';

void main() {
  var buffer = StringBuffer();
  buffer.writeln('// Generated from tool/gen_all.dart');
  buffer.writeln('final files = [');

  var allFiles = Directory('storage')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.json') || f.path.endsWith('.zip'))
      .toList();
  allFiles.sort((a, b) => a.path.compareTo(b.path));
  for (var file in allFiles) {
    buffer.writeln("  '${file.path.replaceAll('\\', '/')}',");
  }
  buffer.writeln('];');
  File('lib/all_files.g.dart').writeAsStringSync('$buffer');
}
