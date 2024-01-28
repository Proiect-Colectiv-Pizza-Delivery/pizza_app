import 'dart:async';

import 'package:pizza_app/data/domain/order.dart';

abstract class OrderRepository {
  final Completer databaseInitialized = Completer();

  Future<Order> addOrder(Order order);

  Future<List<Order>> getOrders();

}