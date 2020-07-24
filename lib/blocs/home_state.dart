part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => null;
}



class HomeInitial extends HomeState {
  HomeInitial() : super();

  @override
  List<Object> get props => [];
}

class LoadDataSuccess extends HomeState {
  final dynamic data;

  LoadDataSuccess(this.data) : super();

  @override
  List<Object> get props => data;
}

class LoadDataFail extends HomeState {
  final dynamic error;

  LoadDataFail(this.error) : super();

  @override
  List<Object> get props => error;
}
