import 'package:main/queries/select_query.dart';

void main() {
  print('SQL Query Builder - Week 1: Polymorphism & Abstraction');
  print('====================================================');

  final query = SelectQuery();
  query.from('users');
  query.where('id', '=', 1);

  final sql = query.build();
  print('Generated SQL: $sql');
}
