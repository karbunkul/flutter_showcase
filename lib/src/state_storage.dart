class StateStorage {
  Map<String, Map<String, dynamic>> _storage = Map();

  void setValues({String id, Map<String, dynamic> values}) {
    _storage[id] = values;
  }

  Map<String, dynamic> getValues(String id) {
    return _storage.containsKey(id) ? _storage[id] : null;
  }
}
