import 'package:flutter/material.dart';
import 'package:buisness/buisness.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ProductBlock _prodBlock;

  @override
  void initState() {
    super.initState();
    _prodBlock = GetIt.I.get<ProductBlock>();
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

  void _cartUpdate(item) {
    context.read<ProductBlock>().addToCart(item);
  }

  void _cartCleaner() {
    context.read<ProductBlock>().cleane();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Полка товаров',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    ...context.watch<ProductBlock>().goods().map(
                          (e) => ListTile(
                            title: Text(
                              'Товар ${e.id}',
                            ),
                            trailing: const Icon(Icons.add_box),
                            onTap: () => _cartUpdate(e),
                          ),
                        )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Корзина',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
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
                  )
                ],
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'К оплате: ${context.watch<ProductBlock>().sum()} у.е.',
                  style: Theme.of(context).textTheme.headline6,
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _cartCleaner(),
        child: const Icon(Icons.delete),
      ),
    );
  }
}
