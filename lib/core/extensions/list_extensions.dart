/// List sınıfı için extension metotlar
extension ListExtension<T> on List<T> {
  /// Listeyi gruplandırma
  Map<K, List<T>> groupBy<K>(K Function(T) keySelector) {
    final map = <K, List<T>>{};
    for (var element in this) {
      final key = keySelector(element);
      if (!map.containsKey(key)) {
        map[key] = <T>[];
      }
      map[key]!.add(element);
    }
    return map;
  }

  /// Belirli bir filtre koşulunu sağlayan ilk elemanı döndürür, yoksa null
  T? firstWhereOrNull(bool Function(T) predicate) {
    for (var element in this) {
      if (predicate(element)) return element;
    }
    return null;
  }

  /// Liste boş mu kontrol eder
  bool get isNullOrEmpty => this.isEmpty;

  /// Liste benzersiz elemanlarını döndürür
  List<T> distinct() {
    return this.toSet().toList();
  }

  /// Listeyi belirli bir özelliğe göre benzersiz hale getirir
  List<T> distinctBy<K>(K Function(T) selector) {
    final result = <T>[];
    final seen = <K>{};
    for (var element in this) {
      final key = selector(element);
      if (seen.add(key)) {
        result.add(element);
      }
    }
    return result;
  }

  /// Listede belirli bir elemanın indeksini döndürür, yoksa -1
  int indexOf(bool Function(T) predicate) {
    for (var i = 0; i < this.length; i++) {
      if (predicate(this[i])) return i;
    }
    return -1;
  }

  /// Listeyi belirli bir büyüklükte parçalara böler
  List<List<T>> chunk(int size) {
    final result = <List<T>>[];
    for (var i = 0; i < this.length; i += size) {
      result.add(this.sublist(i, i + size > this.length ? this.length : i + size));
    }
    return result;
  }
}