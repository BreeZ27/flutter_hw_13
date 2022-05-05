import 'package:flutter/material.dart';
import 'package:buisness/buisness.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class Cart extends ChangeNotifier {
  List cart = [];

  int get totalPrice {
    return cart.length * 16;
  }

  void add(item) {
    cart.add(item);
    notifyListeners();
  }

  void removeAll() {
    cart.clear();
    notifyListeners();
  }
}

class _MyAppState extends State<MyApp> {
  late final ProductBlock _prodBlock;

  @override
  void initState() {
    super.initState();
    _prodBlock = GetIt.I.get<ProductBlock>();
    // _prodBlock.add(const ProductBlockEvent.init());
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return ChangeNotifierProvider<ProductBlock>(
      create: (_) => _prodBlock,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter_hw_13',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyHomePage(
          title: 'Flutter_hw_13',
        ),
      ),
    );
  }

  @override
  void dispose() {
    _prodBlock.dispose();
    super.dispose();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String toShow = 'No data';

  // void _prodUpdate(ProductBlockState state) {
  //   // return context.read<ProductBlock>().add(
  //   //       const ProductBlockEvent.setProd(),
  //   //     );
  // }

  // void _cartCleaner(ProductBlockState state) {
  //   context.read<ProductBlock>().cleane();

  //   return context.read<ProductBlock>().add(
  //         const ProductBlockEvent.addProd(),
  //       );
  // }
  void _cartUpdate(item) {
    context.read<ProductBlock>().addToCart(item);
  }

  void _cartCleaner() {
    context.read<ProductBlock>().cleane();
  }
  // void _cartUpdate(ProductBlockState state, item) {
  //   // context.read<ProductBlock>().productService.myCart.add(item);
  //   context.read<ProductBlock>().addToCart(item);

  //   return context.read<ProductBlock>().add(
  //         const ProductBlockEvent.addProd(),
  //       );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Полка товаров'),
                  ...context.watch<ProductBlock>().goods().map(
                        (e) => ListTile(
                          title: Text(
                            'Товар ${e.id}',
                          ),
                          trailing: Icon(Icons.add_box),
                          onTap: () => _cartUpdate(e),
                        ),
                      )
                ],
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Корзина'),
                ...context.watch<ProductBlock>().show().keys.map(
                      (e) => ListTile(
                        title: Text(
                          'Товар ${e.id}',
                        ),
                        trailing: Text(
                            'x ${context.watch<ProductBlock>().show()[e]}'),
                      ),
                    ),
              ],
            ),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _cartCleaner(),
      ),
    );
  }
}
    // var read = context.read<ProductBlock>().show();

    // return StreamBuilder<ProductBlockState>(
    //   stream: context.read<ProductBlock>().state,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       final state = snapshot.data;
    //       return state!.map<Widget>(
    //         loading: (_) {
    //           return Scaffold(
    //             appBar: AppBar(
    //               title: Text(widget.title),
    //             ),
    //             body: const Center(
    //               child: Text('Loading'),
    //             ),
    //           );
    //         },
    //         loaded: (state) {
    //           return Scaffold(
    //             appBar: AppBar(
    //               title: Text(widget.title),
    //             ),
    //             body: Center(
    //               child: Column(
    //                 children: [
    //                   Expanded(
    //                     child: SingleChildScrollView(
    //                       child: Column(
    //                         children: [
    //                           Container(
    //                             alignment: Alignment.topLeft,
    //                             padding: const EdgeInsets.all(8),
    //                             child: Text(
    //                               'Полка товаров',
    //                               style: Theme.of(context).textTheme.headline6,
    //                             ),
    //                           ),
                              // ...context.read<ProductBlock>().goods().map(
                              //       (e) => ListTile(
                              //         title: Text('Товар ${e.id.toString()}'),
                              //         trailing: const Icon(Icons.add_box),
                              //         onTap: () {
                              //           _cartUpdate(state, e);
                              //         },
                              //       ),
                              //     )
                              // ...state.prodData.array.values.map(
                              //   (e) => ListTile(
                              //     title: Text('Товар ${e.id.toString()}'),
                              //     trailing: const Icon(Icons.add_box),
                              //     onTap: () {
                                    // _cartUpdate(state, e);
                                  // },
                                // ),
                              // ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // const Divider(
                      //   height: 20,
                      //   color: Colors.black,
                      // ),
                      // Expanded(
                      //     child: SingleChildScrollView(
                      //   child: Column(
                      //     children: [
                      //       Container(
                      //         padding: const EdgeInsets.all(8),
                      //         alignment: Alignment.topLeft,
                      //         child: Text(
                      //           'Корзина',
                      //           style: Theme.of(context).textTheme.headline6,
                      //         ),
                      //       ),
                      //       Column(
                      //         children: [
                      //           ...context.read<ProductBlock>().show().keys.map(
                      //                 (e) => ListTile(
                      //                   title: Text('Товар ${e.id}'),
                      //                   trailing:
                      //                       Text('x ${state.prodData.out[e]}'),
                      //                 ),
                      //               )
                                // ...state.prodData.out.keys.map(
                                //   (e) => ListTile(
                                //     title: Text('Товар ${e.id}'),
                                //     trailing:
                                //         Text('x ${state.prodData.out[e]}'),
                                //   ),
                                // ),
                              // ],
                            // )
                //           ],
                //         ),
                //       ))
                //     ],
                //   ),
                // ),
                // floatingActionButton: FloatingActionButton(
                //   onPressed: () => _cartCleaner(state),
                //   // onPressed: () => _prodUpdate(state),
                //   tooltip: 'Increment',
                //   child: const Icon(Icons.delete),
                //   elevation: 50,
                // ),
//               );
//             },
//           );
//         } else {
//           return loading;
//         }
//       },
//     );
//   }
// }
