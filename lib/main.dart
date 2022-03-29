import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redux/redux.dart';

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

enum CounterEvent { increase }

class CounterBloc extends Bloc<CounterEvent, int> {
  int value = 0;

  CounterBloc() : super(0) {
    on<CounterEvent>((event, emit) => emit(state + 1));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<CounterBloc>(
          create: (_) => CounterBloc(),
          child: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterBloc, int>(
              builder: (_, state) => Text(
                state.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CounterBloc>().add(CounterEvent.increase),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
