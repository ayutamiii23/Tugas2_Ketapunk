import '../core/query.dart';
import '../clauses/from_clause.dart';
import '../clauses/where_clause.dart';

class SelectQuery implements Query {
  FromClause? _from;
  WhereClause? _where;

  void from(String tableName) {
    _from = FromClause(tableName);
  }

  void where(String column, String operator, dynamic value) {
    _where = WhereClause(column, operator, value);
  }

  @override
  String build() {
    if (_from == null) {
      throw StateError('FROM clause must be specified');
    }

    var query = 'SELECT * ${_from!.build()}';

    if (_where != null) {
      query += ' ${_where!.build()} ';
    }

    return query;
  }
}
