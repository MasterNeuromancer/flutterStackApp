import 'dart:convert';

import 'package:flutter_stack_app/home/index.dart';
import 'package:http/http.dart' as http;

class HomeProvider {
  HomeProvider();

  Future<QuestionData> getData() async {
    var res =
        await http.get('http://10.0.2.2:8000/stack/questions/?format=json');
    var decodedJson = jsonDecode(res.body);

    QuestionData qd = QuestionData();
    qd.questions = [];
    for (var json in decodedJson) {
      qd.questions.add(Questions.fromJson(json));
    }

    return qd;
  }
}
