import 'dart:io';

import 'package:paste_man/src/storage/abs_storage.dart';
import 'package:paste_man/src/storage/implement/android_storage.dart';

class PasteStorage extends AbsStorage {
  PasteStorage._internal() {
    _storage = _determineStorage();
  }

  static final PasteStorage _instance = PasteStorage._internal();

  factory PasteStorage() => _instance;

  late AbsStorage _storage;

  AbsStorage _determineStorage() {
    if (Platform.isAndroid) {
      _storage = AndroidStorage();
    } else {
      throw UnimplementedError();
    }
    return _storage;
  }

  @override
  Future<bool> clear() {
    return _storage.clear();
  }

  @override
  Future<List<String>> get(String content) {
    return _storage.get(content);
  }

  @override
  Future<int> getCount() {
    return _storage.getCount();
  }

  @override
  Future<List<String>> getFromRange(int start, int end) {
    return _storage.getFromRange(start, end);
  }

  @override
  Future<String> getLatestUpdate() {
    return _storage.getLatestUpdate();
  }

  @override
  Future<bool> put(String lastUpdate) {
    return _storage.put(lastUpdate);
  }

  @override
  Future<bool> remove(String content) {
    return _storage.remove(content);
  }
}
