import 'package:buisness/buisness.dart';
import 'package:flutter/material.dart';
import 'package:product_model/model.dart';

void main() {
  initializeBlocs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  late final MyCubit _prodBlock;

  @override
  void initState() {
    _prodBlock = MyCubit();
    _prodBlock.handleEvent(ProductBlockEvent.add);

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
                                        _prodBlock.addProduct(e);
                                        print('Товар $e добавлен в поток');
                                      },
                                      icon: const Icon(Icons.add_box_outlined)),
                                ),
                              ),
                            ],
                          );
                        } else {
                          print('no snapshot.data');
                          return const Center(
                              child: CircularProgressIndicator());
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
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: StreamBuilder(
                stream: _prodBlock.sumState,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return Text(
                    'К оплате: ${snapshot.data} у.е.',
                    style: Theme.of(context).textTheme.headline6,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _prodBlock.handleEvent(ProductBlockEvent.clear);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.delete),
        elevation: 50,
      ),
    );
  }
}
