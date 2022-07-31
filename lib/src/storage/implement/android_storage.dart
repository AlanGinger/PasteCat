import 'dart:io';

import 'package:paste_man/src/storage/abs_storage.dart';
import 'package:path_provider/path_provider.dart';

class AndroidStorage implements AbsStorage {
  AndroidStorage._internal() {}

  static final AndroidStorage _instance = AndroidStorage._internal();

  factory AndroidStorage() => _instance;

  var _alreadyInit = false;

  var _storage = <String>[];

  Future<bool> _init() async {
    if (_alreadyInit) return true;
    var allContent = await AndroidFileStorage.readAllFromFile();
    if (allContent.isNotEmpty) {
      var originalList = allContent.split('&');
      _storage = originalList.map((e) => Uri.decodeComponent(e)).toList();
    }
    _alreadyInit = true;
    return true;
  }

  @override
  Future<bool> clear() {
    _storage.clear();
    return AndroidFileStorage.writeAllToFile('');
  }

  @override
  Future<List<String>> get(String content) async {
    if (!_alreadyInit) {
      await _init();
    }
    return _storage.where((e) => e.contains(content)).toList();
  }

  @override
  Future<int> getCount() async {
    if (!_alreadyInit) {
      await _init();
    }
    return Future.value(_storage.length);
  }

  @override
  Future<List<String>> getFromRange(int start, int end) async {
    if (!_alreadyInit) {
      await _init();
    }
    if (start < 0 || end < 0 || start > end) {
      throw ArgumentError(
          'start and end must be greater than 0 and start must be less than end');
    }
    if (start >= _storage.length) {
      throw ArgumentError(
          'start and end must be less than storage length, current length is ${_storage.length}, start is $start, end is $end');
    }
    if (start == end) {
      return Future.value([]);
    }
    if (start < _storage.length && end > _storage.length) {
      return Future.value(_storage.sublist(start, _storage.length));
    }

    return _storage.sublist(start, end);
  }

  @override
  Future<String> getLatestUpdate() async {
    if (!_alreadyInit) {
      await _init();
    }
    return Future.value(_storage.last);
  }

  @override
  Future<bool> put(String lastUpdate) async {
    if (!_alreadyInit) {
      await _init();
    }
    _storage.add(lastUpdate);
    var previousContent = await AndroidFileStorage.readAllFromFile();
    var finalContent = '$previousContent&${Uri.encodeComponent(lastUpdate)}';
    return AndroidFileStorage.writeAllToFile(finalContent);
  }

  @override
  Future<bool> remove(String content) async {
    if (!_alreadyInit) {
      await _init();
    }
    _storage.remove(content);
    throw UnimplementedError('Not implemented yet');
  }
}

class AndroidFileStorage {
  static Future<String> readAllFromFile() async {
    final file = File(await getFilePath());
    if (file.existsSync()) {
      final contents = file.readAsStringSync();
      return contents;
    } else {
      return '';
    }
  }

  static Future<bool> writeAllToFile(String content) async {
    final file = File(await getFilePath());
    file.writeAsStringSync(content);
    return true;
  }

  static Future<String> getFilePath() async {
    var path = await getExternalStorageDirectory();
    return '${path?.absolute.path}/FileStorage.txt';
  }

  static Future<bool> appendToFile(String appendMsg) async {
    final file = File(await getFilePath());
    await file.writeAsString(appendMsg, mode: FileMode.append);
    return true;
  }
}
