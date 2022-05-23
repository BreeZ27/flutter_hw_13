import 'package:buisness/buisness.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  initializeBlocs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter_hw_13',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        lazy: false,
        create: (_) => MyBLoc(),
        child: MyHomePage(
          title: 'Flutter_hw_13',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    context.read<MyBLoc>().add(ProductBlockEvent.add);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Page build');

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
                    BlocBuilder<MyBLoc, ProductBlock>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            ...state.goods().keys.map(
                                  (e) => ListTile(
                                    title: Text(
                                      'Товар ${e.id}',
                                    ),
                                    trailing: IconButton(
                                      onPressed: () async {
                                        state.addToCart(e);
                                        await state.give();
                                        print('Товар $e добавлен в поток');
                                        context
                                            .read<MyBLoc>()
                                            .add(ProductBlockEvent.toCart);
                                      },
                                      icon: const Icon(Icons.add_box_outlined),
                                    ),
                                  ),
                                ),
                          ],
                        );
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
                    BlocBuilder<MyBLoc, ProductBlock>(
                      builder: (context, state) {
                        if (state.show().isEmpty == true) {
                          return const Center(child: Text('Корзина пуста'));
                        } else {
                          return Column(
                            children: [
                              ...state.show().keys.map(
                                    (e) => ListTile(
                                      title: Text(
                                        'Товар ${e.id}',
                                      ),
                                      trailing: Text(
                                        'x ${state.show()[e]}',
                                      ),
                                    ),
                                  ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: BlocBuilder<MyBLoc, ProductBlock>(
                    builder: (context, state) {
                  return Text(
                    'К оплате: ${state.sum()} у.е.',
                    style: Theme.of(context).textTheme.headline6,
                  );
                })),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<MyBLoc>().add(ProductBlockEvent.clear);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.delete),
        elevation: 50,
      ),
    );
  }
}
