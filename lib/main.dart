import 'package:buisness/buisness.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

void main() {
  // getIt.registerLazySingleton<ProductBlock>((_) => ProductBlock());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final ProductBlock _prodBlock = ProductBlock();

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
  late final _prodBlock;

  @override
  void initState() {
    _prodBlock = ProductBlock();
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
                        stream: _prodBlock.state,
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            return Text('data');
                          } else {
                            return Text('no data');
                          }
                        })

                    // ...state.prodData.array.values.map(
                    //   (e) => ListTile(
                    //     title: Text('Товар ${e.id.toString()}'),
                    //     trailing: const Icon(Icons.add_box),
                    //     onTap: () {
                    //     },
                    // ),
                    // ),
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
                        ...context.read<ProductBlock>().show().keys.map(
                              (e) => ListTile(
                                title: Text('Товар ${e.id}'),
                                // trailing:
                                // Text('x ${state.prodData.out[e]}'),
                              ),
                            )
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
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.delete),
        elevation: 50,
      ),
    );
  }
}




// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late final CounterBloc bloc;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             StreamBuilder<int>(
//                 stream: bloc.state,
//                 builder: (_, snapshot) {
//                   if (snapshot.hasData) {
//                     return Text(
//                       snapshot.data?.toString() ?? '',
//                       style: Theme.of(context).textTheme.headline4,
//                     );
//                   } else {
//                     return const SizedBox.shrink();
//                   }
//                 })
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => bloc.action.add(CounterEvent.increase),
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     bloc = CounterBloc();
//   }

//   @override
//   void dispose() {
//     bloc.dispose();
//     super.dispose();
//   }
// }

// // class MyHomePage extends ConsumerWidget {
// //   const MyHomePage({Key? key, required this.title}) : super(key: key);
// //   final String title;

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final count = ref.watch(counterProvider);
// //     final provider = ref.watch(counterProvider.notifier);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(title),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             const Text(
// //               'You have pushed the button this many times:',
// //             ),
// //             Text(
// //               count.toString(),
// //               style: Theme.of(context).textTheme.headline4,
// //             ),
// //           ],
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: provider.increment,
// //         tooltip: 'Increment',
// //         child: const Icon(Icons.add),
// //       ),
// //     );
// //   }
// // }
