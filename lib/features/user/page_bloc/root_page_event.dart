part of 'root_page_bloc.dart';

abstract class RootPageEvent extends Equatable {
  const RootPageEvent();
}

class ChangePage extends RootPageEvent{
  final int index;

  const ChangePage(this.index);

  @override
  List<Object?> get props => [index];

}