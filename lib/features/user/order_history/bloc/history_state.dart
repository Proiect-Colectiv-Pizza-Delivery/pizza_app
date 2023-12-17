part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  final List<Order> orders;

  const HistoryState(this.orders);
}

class HistoryInitial extends HistoryState {
  const HistoryInitial(super.orders);

  @override
  List<Object> get props => [];
}

class HistoryLoading extends HistoryState {
  const HistoryLoading(super.orders);

  @override
  List<Object> get props => [];
}

class HistoryLoaded extends HistoryState {
  const HistoryLoaded(super.orders);

  @override
  List<Object> get props => [];
}
