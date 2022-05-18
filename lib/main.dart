import 'package:buisness/buisness.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:product_model/model.dart';

void main() {
  initializeBlocs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

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

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    print('Page build');
    context.read<MyBLoc>().add();

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
                                      onPressed: () {
                                        print('Товар $e добавлен в поток');
                                        context.read<MyBLoc>().toCart(e);
                                      },
                                      icon: Icon(Icons.add_box_outlined),
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
                          return Center(child: Text('Корзина пуста'));
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
          context.read<MyBLoc>().clear();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.delete),
        elevation: 50,
      ),
    );
  }
}
