import 'dart:async';
import 'package:data/data.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productBlockProvider =
    StateNotifierProvider<ProductBlock, ProductService>((_) {
  return ProductBlock();
});

@injectable
class ProductBlock extends StateNotifier<ProductService> {
  final ProductService productService = MyProductService();

  ProductBlock() : super(MyProductService());

  void addToCart(item) async {
    productService.addToCart(item);
    await productService.give();
    print("BLOCK ADD");
  }

  void cleane() {
    productService.cleane();
  }

  void create(i) async {
    await productService.createProducts(i);
  }

  goods() {
    return productService.array.values;
  }

  show() {
    // await Future.delayed(Duration(seconds: 1));
    return productService.show();
  }

  sum() {
    var _res = 0;
    for (var item in productService.out.values) {
      _res += item;
    }
    _res *= 48;
    print('BLOCK SUM');
    return _res;
  }
}
