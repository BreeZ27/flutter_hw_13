import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
  runApp(MyApp());
}

class CounterIncremetAction {}

@immutable
class AppState {
  final int value;

  const AppState({this.value = 0});

  factory AppState.initial() => const AppState();

  AppState copyWith({int? value}) {
    return AppState(value: value ?? this.value);
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashcode => value.hashCode;

  @override
  String toString() {
    return 'AppState{value: $value}';
  }
}

final incrementReducer = combineReducers<int>([
  TypedReducer<int, CounterIncremetAction>(_increment),
]);

int _increment(int value, CounterIncremetAction action) => ++value;

AppState appReducer(AppState state, action) {
  return state.copyWith(value: incrementReducer(state.value, action));
}

class CounterConnector extends StatelessWidget {
  const CounterConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return MyHomePage(
          title: 'Flutter_HW_13',
          value: vm.value,
          increase: vm.onIncrease,
        );
      },
    );
  }
}

class _ViewModel {
  final int value;
  final VoidCallback onIncrease;

  _ViewModel({required this.value, required this.onIncrease});

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        value: store.state.value,
        onIncrease: () => store.dispatch(
          CounterIncremetAction(),
        ),
      );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final store = Store(appReducer, initialState: AppState.initial());

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: CounterConnector(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    required this.value,
    required this.increase,
  }) : super(key: key);

  final String title;
  final int value;
  final VoidCallback increase;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              widget.value.toString(),
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.increase,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
