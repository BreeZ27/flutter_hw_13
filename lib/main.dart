import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:buisness/buisness.dart';
import 'package:get_it/get_it.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
  initializeBlocs();
  runApp(MyApp());
}

class ProductBlockClearAction {}

class ProductBlockAddAction {}

class ProductBlockToCartAction {}

final clearReducer = combineReducers<ProductBlock>(
    [TypedReducer<ProductBlock, ProductBlockClearAction>(_clear)]);

ProductBlock _clear(ProductBlock productBlock, ProductBlockClearAction action) {
  productBlock.cleaning();
  print('ProductBlock _clear');
  return productBlock;
}

AppState appReducer(AppState state, action) {
  var a = clearReducer(state.productBlock, action);
  print('AppState appReducer $a');
  var _newState = state.duplicate(clearReducer(a, action));

  return _newState;
}

@immutable
class AppState {
  late final ProductBlock productBlock;

  AppState(ProductBlock block) {
    this.productBlock = block;
  }

  factory AppState.initial() => AppState(ProductBlock());

  duplicate(ProductBlock inlet) {
    ProductBlock _outlet = ProductBlock();
    _outlet.productService.out = inlet.productService.out;
    _outlet.productService.array = inlet.productService.array;
    _outlet.productService.myCart = inlet.productService.myCart;
    return _outlet;
  }

  AppState copyWith({
    required ProductBlock value,
  }) {
    return AppState(value);
  }
}

class MyConnector extends StatelessWidget {
  const MyConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          return MyHomePage(
            title: 'Flutter_HW_13',
            add: vm.onAdd,
            clear: vm.onClear,
            toCart: vm.onToCart,
            productBlock: vm.productBlock,
          );
        });
  }
}

class _ViewModel {
  final ProductBlock productBlock;
  final VoidCallback onToCart;
  final VoidCallback onClear;
  final VoidCallback onAdd;

  _ViewModel({
    required this.productBlock,
    required this.onToCart,
    required this.onClear,
    required this.onAdd,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      productBlock: store.state.productBlock,
      onClear: () => store.dispatch(ProductBlockClearAction()),
      onAdd: () => store.dispatch(ProductBlockAddAction()),
      onToCart: () => store.dispatch(ProductBlockToCartAction()),
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
  );

  @override
  Widget build(BuildContext context) {
    print('build');
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter_hw_13',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyConnector(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    required this.add,
    required this.productBlock,
    required this.clear,
    required this.toCart,
  }) : super(key: key);

  final String title;
  final ProductBlock productBlock;
  final VoidCallback toCart;
  final VoidCallback clear;
  final VoidCallback add;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Полка товаров',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 20,
              color: Colors.black,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Корзина',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Column(
                    children: [],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        // onPressed: () => _prodUpdate(state),
        tooltip: 'Increment',
        child: const Icon(Icons.delete),
        elevation: 50,
      ),
    );
  }
}
