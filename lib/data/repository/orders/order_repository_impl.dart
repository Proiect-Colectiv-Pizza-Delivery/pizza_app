import 'package:pizza_app/data/domain/order.dart';

import 'order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  late List<Order> _orders;
  int latestId = 11;

  OrderRepositoryImpl() {
    _orders = Order.getPopulation();
    super.databaseInitialized.complete();
  }

  @override
  Future<Order> addOrder(Order order) {
    Order savedOrder = order.copyWith(id: latestId);
    _orders.add(savedOrder);
    latestId++;
    throw savedOrder;
  }

  @override
  Future<List<Order>> getOrders() async{
    await Future.delayed(const Duration(milliseconds: 200));
    return _orders;
  }
}
