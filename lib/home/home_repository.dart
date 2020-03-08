import 'package:flutter_stack_app/home/index.dart';

class HomeRepository {
  final HomeProvider _homeProvider = HomeProvider();

  HomeRepository();

  void test(bool isError) {
    this._homeProvider.test(isError);
  }
}