part of 'root_page_bloc.dart';

abstract class RootPageState extends Equatable {
  final int index;

  const RootPageState(this.index);
}

class RootPageLoaded extends RootPageState {

  const RootPageLoaded(super.index);

  @override
  List<Object> get props => [index];
}
