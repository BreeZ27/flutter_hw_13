import 'package:flutter/material.dart';
import 'package:buisness/buisness.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:product_model/model.dart';

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

class ProductBlockToCartAction {
  // final ProductData product;
  // ProductBlockToCartAction({required this.product});
}

final productReducer = combineReducers<ProductBlock>([
  TypedReducer<ProductBlock, ProductBlockClearAction>(_clear),
  TypedReducer<ProductBlock, ProductBlockAddAction>(_add),
  TypedReducer<ProductBlock, ProductBlockToCartAction>(_toCart),
]);

ProductBlock _clear(ProductBlock productBlock, ProductBlockClearAction action) {
  print('ProductBlock _clear');
  productBlock.clean();
  return productBlock;
  // ProductBlock _newProductBlock = duplicate(productBlock);
  // _newProductBlock.clean();
  // return _newProductBlock;
}

ProductBlock _add(ProductBlock productBlock, ProductBlockAddAction action) {
  print('ProductBlock _add');
  productBlock.createPrd(5);
  return productBlock;
  // ProductBlock _newProductBlock = duplicate(productBlock);
  // _newProductBlock.createPrd(5);
  // return _newProductBlock;
}

ProductBlock _toCart(
    ProductBlock productBlock, ProductBlockToCartAction action) {
  print('ProductBlock _toCart');
  productBlock.give();
  return productBlock;
  // ProductBlock _newProductBlock = duplicate(productBlock);
  // _newProductBlock.give();
  // return _newProductBlock;
}

AppState appReducer(AppState state, action) {
  // Future.delayed(Duration(seconds: 2));
  print('appReducer started');
  return AppState(productReducer(duplicate(state.productBlock), action));
}

@immutable
class AppState {
  late final ProductBlock productBlock;

  AppState(ProductBlock block) {
    productBlock = block;
  }

  factory AppState.initial() {
    print('AppState initial');
    return AppState(ProductBlock());
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
    print('MyConnector started');
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => MyHomePage(
        title: 'Flutter_HW_13',
        add: vm.onAdd,
        clear: vm.onClear,
        toCart: vm.onToCart,
        productBlock: vm.productBlock,
        initFunc: () {
          StoreProvider.of<AppState>(context).dispatch(ProductBlockAddAction());
          print('MyConnector dispatched');
        },
      ),
    );
  }
}

class _ViewModel {
  final ProductBlock productBlock;
  final Function() onToCart;
  final Function() onClear;
  final Function() onAdd;

  _ViewModel({
    required this.productBlock,
    required this.onToCart,
    required this.onClear,
    required this.onAdd,
  }) {
    print('_ViewModel started');
  }

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
    print('MyApp started');
    return StoreProvider<AppState>(
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

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key,
      required this.title,
      required this.add,
      required this.productBlock,
      required this.clear,
      required this.toCart,
      required this.initFunc})
      : super(key: key);

  final String title;
  final ProductBlock productBlock;
  final VoidCallback toCart;
  final VoidCallback clear;
  final VoidCallback add;
  final Function initFunc;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    widget.initFunc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('MyHomePage started');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                    ...widget.productBlock.goods().keys.map(
                          (e) => ListTile(
                            title: Text(
                              'Товар ${e.id}',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.add_box_outlined),
                              onPressed: () async {
                                widget.productBlock.addToCart(e);
                                widget.toCart();
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
                        ...widget.productBlock.show().keys.map(
                              (e) => ListTile(
                                title: Text(
                                  'Товар ${e.id}',
                                ),
                                trailing:
                                    Text('x ${widget.productBlock.show()[e]}'),
                              ),
                            ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.clear();
        },
        // onPressed: () => _prodUpdate(state),
        tooltip: 'Increment',
        child: const Icon(Icons.delete),
        elevation: 50,
      ),
    );
  }
}



// class MyHomePage extends StatelessWidget {
//   const MyHomePage(
//       {Key? key,
//       required this.title,
//       required this.add,
//       required this.productBlock,
//       required this.clear,
//       required this.toCart,
//       required this.initFunc})
//       : super(key: key);

//   final String title;
//   final ProductBlock productBlock;
//   final VoidCallback toCart;
//   final VoidCallback clear;
//   final VoidCallback add;
//   final Function initFunc;

//   @override
//   Widget build(BuildContext context) {
//     print('MyHomePage started');
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       alignment: Alignment.topLeft,
//                       padding: const EdgeInsets.all(8),
//                       child: Text(
//                         'Полка товаров',
//                         style: Theme.of(context).textTheme.headline6,
//                       ),
//                     ),
//                     ...productBlock.goods().keys.map(
//                           (e) => ListTile(
//                             title: Text(
//                               'Товар ${e.id}',
//                             ),
//                             trailing: IconButton(
//                               icon: const Icon(Icons.add_box_outlined),
//                               onPressed: () async {
//                                 productBlock.addToCart(e);
//                                 toCart;
//                                 // add;
//                               },
//                             ),
//                           ),
//                         ),
//                   ],
//                 ),
//               ),
//             ),
//             const Divider(
//               height: 20,
//               color: Colors.black,
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       alignment: Alignment.topLeft,
//                       child: Text(
//                         'Корзина',
//                         style: Theme.of(context).textTheme.headline6,
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         ...productBlock.show().keys.map(
//                               (e) => ListTile(
//                                 title: Text(
//                                   'Товар ${e.id}',
//                                 ),
//                                 trailing: Text('x ${productBlock.show()[e]}'),
//                               ),
//                             ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           clear();
//         },
//         // onPressed: () => _prodUpdate(state),
//         tooltip: 'Increment',
//         child: const Icon(Icons.delete),
//         elevation: 50,
//       ),
//     );
//   }
// }
