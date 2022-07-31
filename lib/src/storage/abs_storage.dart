abstract class AbsStorage {

  Future<String> getLatestUpdate();

  Future<List<String>> getFromRange(int start, int end);

  Future<int> getCount();

  Future<bool> put(String lastUpdate);

  Future<List<String>> get(String content);

  Future<bool> remove(String content);

  Future<bool> clear();
}
