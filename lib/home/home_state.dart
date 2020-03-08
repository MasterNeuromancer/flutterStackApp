import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  HomeState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  HomeState getStateCopy();

  HomeState getNewVersion();

  @override
  List<Object> get props => ([version, ...propss ?? []]);
}

/// UnInitialized
class UnHomeState extends HomeState {

  UnHomeState(int version) : super(version);

  @override
  String toString() => 'UnHomeState';

  @override
  UnHomeState getStateCopy() {
    return UnHomeState(0);
  }

  @override
  UnHomeState getNewVersion() {
    return UnHomeState(version+1);
  }
}

/// Initialized
class InHomeState extends HomeState {
  final String hello;

  InHomeState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InHomeState $hello';

  @override
  InHomeState getStateCopy() {
    return InHomeState(this.version, this.hello);
  }

  @override
  InHomeState getNewVersion() {
    return InHomeState(version+1, this.hello);
  }
}

class ErrorHomeState extends HomeState {
  final String errorMessage;

  ErrorHomeState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorHomeState';

  @override
  ErrorHomeState getStateCopy() {
    return ErrorHomeState(this.version, this.errorMessage);
  }

  @override
  ErrorHomeState getNewVersion() {
    return ErrorHomeState(version+1, this.errorMessage);
  }
}
