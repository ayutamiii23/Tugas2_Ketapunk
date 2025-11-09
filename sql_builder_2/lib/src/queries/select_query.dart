import '../core/query.dart';
import '../clauses/from_clause.dart';
import '../clauses/where_clause.dart';
import '../enums/sql_operator.dart';

class SelectQuery implements Query {
  FromClause? _from;
  WhereClause? _where;

  SelectQuery from(String tableName) {
    _from = FromClause(tableName);
    return this;
  }

  SelectQuery where(String column, SqlOperator operator, dynamic value) {
    _where ??= WhereClause();
    _where!.addCondition(column, operator, value);
    return this;
  }

  SelectQuery or() {
    _where?.or();
    return this;
  }

  SelectQuery and() {
    _where?.and();
    return this;
  }

  SelectQuery startGroup() {
    _where ??= WhereClause();
    _where!.startGroup();
    return this;
  }

  SelectQuery endGroup() {
    _where?.endGroup();
    return this;
  }

  SelectQuery group(void Function(SelectQuery q) callback) {
    _where ??= WhereClause();
    _where!.startGroup();
    callback(this);
    _where!.endGroup();
    return this;
  }

  @override
  String build() {
    if (_from == null) throw StateError('FROM clause must be specified');

    final parts = ['SELECT * ', _from!.build()];
    if (_where != null) {
      parts.add(_where!.build());
    }

    parts.add(';');
    return parts.join('');
  }
}
