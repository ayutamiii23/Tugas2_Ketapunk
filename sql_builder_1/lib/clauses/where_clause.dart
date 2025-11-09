import '../core/query.dart';

class WhereClause extends Query{
  String column;
  String oprator;
  dynamic value;

  WhereClause(this.column, this.oprator, this.value);

  @override
  String build() {
    if (value is String) {
      return "WHERE $column $oprator '$value'";
    } else {
      return "WHERE $column $oprator $value";
    }
  }
}