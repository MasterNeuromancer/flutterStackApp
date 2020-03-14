import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stack_app/home/index.dart';
import 'package:pk_skeleton/pk_skeleton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
    @required HomeBloc homeBloc,
  })  : _homeBloc = homeBloc,
        super(key: key);

  final HomeBloc _homeBloc;

  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  HomeScreenState();

  @override
  void initState() {
    super.initState();
    this._load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: widget._homeBloc,
        builder: (
          BuildContext context,
          HomeState currentState,
        ) {
          if (currentState is UnHomeState) {
            return PKCardListSkeleton();
          }
          if (currentState is ErrorHomeState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('reload'),
                    onPressed: () => this._load(),
                  ),
                ),
              ],
            ));
          }
          if (currentState is InHomeState) {
            QuestionData questionData = currentState.questionData;
            return Material(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xffd399c1),
                              Color(0xff9b5acf),
                              Color(0xff611cdf),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        title: Text('Stack Overflow'),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.15,
                        left: 20.0,
                        right: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          'Hi, Welcome to the Stack Overflow Questions App!',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'All Questions',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: questionData.questions.length,
                      itemBuilder: (context, i) {
                        Questions questions = questionData.questions[i];
                        String tags = questions.tags;
                        tags = tags.substring(1, tags.length - 1);
                        var tagList = tags.split(',');
                        return ListTile(
                          dense: true,
                          isThreeLine: true,
                          leading: CircleAvatar(
                            radius: 25.0,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueGrey,
                            child: Text(
                              questions.voteCount.toString(),
                            ),
                          ),
                          title: Text(
                            questions.question,
                          ),
                          trailing: Chip(
                            label: Text(
                              questions.views,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.blueGrey,
                          ),
                          subtitle: Wrap(
                            children: tagList
                                .map(
                                  (t) => Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Chip(
                                      label: Text(
                                        t,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Color(0xff9b5acf),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _load([bool isError = false]) {
    widget._homeBloc.add(UnHomeEvent());
    widget._homeBloc.add(LoadHomeEvent(isError));
  }
}
