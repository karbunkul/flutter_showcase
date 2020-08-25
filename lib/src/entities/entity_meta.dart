class EntityMeta<T> {
  final bool current;
  final T entity;

  EntityMeta({this.current = false, this.entity});

  EntityMeta<T> copyWith({bool current = false}) {
    return EntityMeta<T>(
      entity: this.entity,
      current: current ?? this.current,
    );
  }
}
