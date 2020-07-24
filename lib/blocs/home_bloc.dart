import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_graphql/services/graphql_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  GraphQLService service;

  HomeBloc() : super(HomeInitial()){
    service = GraphQLService();
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchHomeData) {
      yield* _mapFetchHomeDataToStates(event);
    }
  }

  Stream<HomeState> _mapFetchHomeDataToStates(FetchHomeData event) async* {
    final query = event.query;
    final variables = event.variables ?? null;

    try {
      final result = await service.performMutation(query, variables: variables);

      if (result.hasException) {
        print('graphQLErrors: ${result.exception.graphqlErrors.toString()}');
        print('clientErrors: ${result.exception.clientException.toString()}');
        yield LoadDataFail(result.exception.graphqlErrors[0]);
      } else {
        yield LoadDataSuccess(result.data);
      }
    } catch (e) {
      print(e);
      yield LoadDataFail(e.toString());
    }
  }
}