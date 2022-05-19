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
        create: (_) => MyBLoC(),
        child: const MyHomePage(
          title: 'Flutter_hw_13',
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    print('Page build');
    context.read<MyBLoC>().add();

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
                    BlocBuilder<MyBLoC, ProductBlock>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            ...state.goods().keys.map(
                                  (e) => ListTile(
                                    title: Text(
                                      'Товар ${e.id}',
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        print('Товар $e добавлен в поток');
                                        context.read<MyBLoC>().toCart(e);
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
                    BlocBuilder<MyBLoC, ProductBlock>(
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
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<MyBLoC>().clear();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.delete),
        elevation: 50,
      ),
    );
  }
}
