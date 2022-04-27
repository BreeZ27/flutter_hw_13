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
    _prodBlock.add(const ProductBlockEvent.init());
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ProductBlock>(
      create: (_) => _prodBlock,
      child: MaterialApp(
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

  final loading = const Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    ),
  );

  void _prodUpdate(ProductBlockState state) {
    return context.read<ProductBlock>().add(
          const ProductBlockEvent.setProd(),
        );
  }

  @override
  Widget build(BuildContext context) {
    var read = context.read<ProductBlock>().show();

    return StreamBuilder<ProductBlockState>(
      stream: context.read<ProductBlock>().state,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final state = snapshot.data;
          return state!.map<Widget>(
            loading: (_) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                ),
                body: const Center(
                  child: Text('Loading'),
                ),
              );
            },
            loaded: (state) {
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
                              ...state.prodData.map((e) => ListTile(
                                    title: Text('Товар ${e.id.toString()}'),
                                    trailing: const Icon(Icons.add_box),
                                    onTap: () {},
                                  )),
                              // read != null ? Text(read) : Text('None')
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 20,
                        color: Colors.black,
                      ),
                      Expanded(
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
                          SingleChildScrollView(
                            child: Column(
                              children: [],
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => _prodUpdate(state),
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                  elevation: 50,
                ),
              );
            },
          );
        } else {
          return loading;
        }
      },
    );
  }
}
