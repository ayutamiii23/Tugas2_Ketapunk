import '../core/query.dart';
import '../core/conditional.dart';
import '../enums/sql_operator.dart';
import '../enums/sql_logical.dart';
import 'condition.dart';

class WhereClause implements Query, Conditional {
  final List<String> _outerStack = [];
  final List<String> _groupStack = [];
  bool isGroup = false;

  void addCondition(String column, SqlOperator operator, dynamic value) {
    final val = value is String ? "'$value'" : value;
    final condition = '$column ${operator.symbol} $val';
    final targetStack = isGroup ? _groupStack : _outerStack;
    targetStack.add(condition);
  }

  void or() {
    final targetStack = isGroup ? _groupStack : _outerStack;
    targetStack.add('OR');
  }

  void and() {
    final targetStack = isGroup ? _groupStack : _outerStack;
    targetStack.add('AND');
  }

  void startGroup() {
    isGroup = true;
    _groupStack.clear();
  }

  void endGroup() {
    if (_groupStack.isNotEmpty) {
      final groupCondition = '(${_groupStack.join(' ')})';
      _outerStack.add(groupCondition);
      _groupStack.clear();
    }
    isGroup = false;
  }

  @override
  String build() {
    if (_outerStack.isEmpty) return '';
    return ' WHERE ${_outerStack.join(' ')}';
  }

  @override
  String buildCondition() => build();
}
