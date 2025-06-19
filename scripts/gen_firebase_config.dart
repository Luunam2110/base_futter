import 'dart:convert';
import 'dart:io';

void main(List<String> args) async {
  // Lấy tên môi trường từ dòng lệnh (mặc định là 'dev')
  final env = args.firstWhere(
        (arg) => arg.startsWith('--env='),
    orElse: () => '--env=dev',
  ).split('=').last;

  final inputPath = 'lib/core/env/$env/${env}_firebase_config.json';
  const outputPath = 'web/firebase-config.js';

  final jsonFile = File(inputPath);
  if (!await jsonFile.exists()) {
    stderr.writeln('❌ Config file not found: $inputPath');
    exit(1);
  }

  final jsonContent = jsonDecode(await jsonFile.readAsString());

  final buffer = StringBuffer()
    ..writeln('const firebaseConfig = {');


  for (final entry in jsonContent.entries) {
    final key = toCamelCase(entry.key.toString());
    final value = entry.value.toString().replaceAll('"', r'\"');
    buffer.writeln('  $key: "$value",');
  }

  buffer.writeln('};');

  final outputFile = File(outputPath);
  await outputFile.writeAsString(buffer.toString());

  stdout.writeln('✅ Generated $outputPath from $inputPath');
}

String toCamelCase(String input) {
  final parts = input.split('_');
  if (parts.isEmpty) return input;

  return parts.first + parts.skip(1).map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1);
  }).join();
}