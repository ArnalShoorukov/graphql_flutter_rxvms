part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => null;
}

class FetchHomeData extends HomeEvent {
  final String query;
  final Map<String, dynamic> variables;

  FetchHomeData(this.query, {this.variables}) : super();

  @override
  List<Object> get props => [query, variables];
}