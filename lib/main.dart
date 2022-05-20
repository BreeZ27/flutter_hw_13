import 'package:flutter/material.dart';
import 'package:buisness/buisness.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
  initializeBlocs();
  runApp(MyApp());
}

duplicate(ProductBlock inlet) {
  ProductBlock _outlet = ProductBlock();
  _outlet.productService.out = inlet.productService.out;
  _outlet.productService.array = inlet.productService.array;
  _outlet.productService.myCart = inlet.productService.myCart;
  return _outlet;
}

class ProductBlockClearAction {}

class ProductBlockAddAction {}

class ProductBlockToCartAction {}

final clearReducer = combineReducers<ProductBlock>(
    [TypedReducer<ProductBlock, ProductBlockClearAction>(_clear)]);

final addReducer = combineReducers<ProductBlock>(
    [TypedReducer<ProductBlock, ProductBlockAddAction>(_add)]);

final toCartReducer = combineReducers<ProductBlock>(
    [TypedReducer<ProductBlock, ProductBlockToCartAction>(_toCart)]);

ProductBlock _clear(ProductBlock productBlock, ProductBlockClearAction action) {
  ProductBlock _newProductBlock = duplicate(productBlock);
  _newProductBlock.clean();
  print('ProductBlock _clear');
  return _newProductBlock;
}

ProductBlock _add(ProductBlock productBlock, ProductBlockAddAction action) {
  ProductBlock _newProductBlock = duplicate(productBlock);
  _newProductBlock.createPrd(5);
  print('ProductBlock _add');
  return _newProductBlock;
}

ProductBlock _toCart(
    ProductBlock productBlock, ProductBlockToCartAction action) {
  ProductBlock _newProductBlock = duplicate(productBlock);
  _newProductBlock.give();
  print('ProductBlock _toCart');
  return _newProductBlock;
}

AppState appReducer(AppState state, action) {
  print('appReducer started');
  if (action == ProductBlockClearAction()) {
    print('appReducer: ProductBlockClearAction');
    return duplicate(
      clearReducer(state.productBlock, action),
    );
  }
  if (action == ProductBlockAddAction()) {
    print('appReducer: ProductBlockClearAction');
    return duplicate(
      addReducer(state.productBlock, action),
    );
  }
  if (action == ProductBlockToCartAction()) {
    print('appReducer: ProductBlockClearAction');
    return duplicate(
      toCartReducer(state.productBlock, action),
    );
  } else {
    return duplicate(toCartReducer(state.productBlock, action));
  }
}

// var a = clearReducer(state.productBlock, action);
// print('AppState appReducer $a');
// var _newState = state.duplicate(clearReducer(a, action));

// return _newState;

@immutable
class AppState {
  late final ProductBlock productBlock;

  AppState(ProductBlock block) {
    productBlock = block;
  }

  factory AppState.initial() {
    ProductBlock _productBlock = ProductBlock();
    // _productBlock.createPrd(5);
    print('AppState initial');
    return AppState(_productBlock);
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
          MyHomePage _myHomePage = MyHomePage(
            title: 'Flutter_HW_13',
            add: vm.onAdd,
            clear: vm.onClear,
            toCart: vm.onToCart,
            productBlock: vm.productBlock,
          );
          return _myHomePage;
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
                    ...productBlock.goods().keys.map(
                          (e) => ListTile(
                            title: Text(
                              'Товар ${e.id}',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.add_box_outlined),
                              onPressed: () async {
                                productBlock.addToCart(e);
                                toCart;
                                // add;
                              },
                            ),
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
                    children: [
                      ...productBlock.show().keys.map(
                            (e) => ListTile(
                              title: Text(
                                'Товар ${e.id}',
                              ),
                              trailing: Text('x ${productBlock.show()[e]}'),
                            ),
                          ),
                    ],
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
