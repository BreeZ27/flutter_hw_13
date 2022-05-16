import 'package:buisness/buisness.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:product_model/model.dart';

void main() {
  // getIt.registerLazySingleton<ProductBlock>((_) => ProductBlock());
  initializeBlocs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // final ProductBlock _prodBlock = GetIt.I.get<ProductBlock>();

  @override
  Widget build(BuildContext context) {
    print('build');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter_hw_13',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(
        title: 'Flutter_hw_13',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final MyBLoc _prodBlock;

  @override
  void initState() {
    _prodBlock = MyBLoc();
    _prodBlock.action.add(ProductBlockEvent.add);
    super.initState();
  }

  @override
  void dispose() {
    _prodBlock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    StreamBuilder(
                      stream: _prodBlock.goodsState,
                      builder: (BuildContext context,
                          AsyncSnapshot<Map<ProductData, int>> snapshot) {
                        if (snapshot.hasData) {
                          print('snapshot.data: ${snapshot.data}');
                          var _out = snapshot.data;
                          return Column(
                            children: [
                              ..._out!.keys.map(
                                (e) => ListTile(
                                  title: Text(
                                    'Товар ${e.id}',
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        _prodBlock.addAction.add(e);
                                        print('Товар $e добавлен в поток');
                                      },
                                      icon: Icon(Icons.add_box_outlined)),
                                ),
                              ),
                            ],
                          );
                        } else {
                          print('no snapshot.data');
                          return Center(child: CircularProgressIndicator());
                        }
                      },
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
                    StreamBuilder(
                      stream: _prodBlock.cartState,
                      builder: (BuildContext context,
                          AsyncSnapshot<Map<ProductData, int>> snapshot) {
                        if (snapshot.hasData) {
                          print('CART snapshot.data: ${snapshot.data}');
                          var _out = snapshot.data;
                          if (_out!.isEmpty == true) {
                            return Center(child: Text('Корзина пуста'));
                          } else {
                            return Column(
                              children: [
                                ..._out.keys.map(
                                  (e) => ListTile(
                                    title: Text(
                                      'Товар ${e.id}',
                                    ),
                                    trailing: Text(
                                      'x ${_out[e]}',
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        } else {
                          print('no snapshot.data');
                          return Center(child: Text('Корзина пуста'));
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _prodBlock.action.add(ProductBlockEvent.clear);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.delete),
        elevation: 50,
      ),
    );
  }
}
