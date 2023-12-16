part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
}

class FetchHistory extends HistoryEvent {
  const FetchHistory();

  @override
  List<Object?> get props => [];
}
