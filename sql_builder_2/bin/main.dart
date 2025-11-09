import 'package:main/src/enums/sql_operator.dart';
import 'package:main/src/queries/select_query.dart';

void main() {
  final query1 = SelectQuery();
  query1
      .from("orders")
      .where("payment_status", SqlOperator.equals, "paid")
      .and()
      .group((q) {
        q
            .where("status", SqlOperator.equals, "Shipping")
            .or()
            .where("status", SqlOperator.equals, "Pending");   
      })
      .and()
      .where('order_id', SqlOperator.greaterThan, 100);

  print('SQL: ${query1.build()}');
}
