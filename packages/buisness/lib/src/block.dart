import 'dart:async';
import 'package:data/data.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final productBlockProvider =
//     StateNotifierProvider<ProductBlock, ProductService>((ref) {
//   return ProductBlock();
// });

// @injectable
// class ProductBlockNotifier extends StateNotifier<ProductBlock>{
//   ProductBlockNotifier() : super(ProductBlock());
// }

@injectable
class ProductBlock {
  final ProductService productService;

  ProductBlock({required this.productService}) {
    productService.createProducts(5);
  }

  void addToCart(item) async {
    productService.addToCart(item);
    productService.give();
    print("BLOCK ADD");
  }

  void cleane() => productService.cleane();

  void create(i) async {
    await productService.createProducts(5);
  }

  goods() => productService.store();

  show() => productService.show();

  sum() {
    var _res = 0;
    for (var item in productService.out.values) {
      _res += item;
    }
    _res *= 48;
    return _res;
  }
}
