import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter_stack_app/home/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent {
  Future<HomeState> applyAsync(
      {HomeState currentState, HomeBloc bloc});
  final HomeRepository _homeRepository = HomeRepository();
}

class UnHomeEvent extends HomeEvent {
  @override
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc}) async {
    return UnHomeState(0);
  }
}

class LoadHomeEvent extends HomeEvent {
   
  final bool isError;
  @override
  String toString() => 'LoadHomeEvent';

  LoadHomeEvent(this.isError);

  @override
  Future<HomeState> applyAsync(
      {HomeState currentState, HomeBloc bloc}) async {
    try {
      if (currentState is InHomeState) {
        return currentState.getNewVersion();
      }
      await Future.delayed(Duration(seconds: 2));
      this._homeRepository.test(this.isError);
      return InHomeState(0, 'Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadHomeEvent', error: _, stackTrace: stackTrace);
      return ErrorHomeState(0, _?.toString());
    }
  }
}
