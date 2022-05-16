import 'package:flutter/material.dart';
import 'package:buisness/buisness.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build');
    return ProviderScope(
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
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  static int starter = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(productBlockProvider);
    final provider = ref.watch(productBlockProvider.notifier);

    void _cartUpdate(item) {
      provider.addProd(item);
      store.addToCart(item);
    }

    void _cartCleaner() {
      provider.cleaning();
    }

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(8),
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
                    ...provider.giveGoods().keys.map(
                      (e) {
                        return ListTile(
                          title: Text(
                            'Товар ${e.id}',
                          ),
                          trailing: const Icon(Icons.add_box),
                          onTap: () => _cartUpdate(e),
                        );
                      },
                    ),
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
                        ...provider.giveShow().keys.map(
                              (e) => ListTile(
                                title: Text(
                                  'Товар ${e.id}',
                                ),
                                trailing: Text(
                                  'x ${provider.giveShow()[e]}',
                                ),
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
                'К оплате: ${provider.giveSum()} у.е.',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
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
