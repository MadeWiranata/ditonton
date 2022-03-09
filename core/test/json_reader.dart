import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  // ignore: unnecessary_string_escapes
  if (dir.endsWith('/core') || dir.endsWith('\core')) {
    return File('$dir/test/$name').readAsStringSync();
  }
  return File('$dir/core/test/$name').readAsStringSync();
}
