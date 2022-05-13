import 'dart:async';
import 'package:data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

GetIt getIt = GetIt.instance;

// final productBlockProvider = Provider<ProductBlock>((ref) {
//   return ProductBlock(productService: getIt.get<ProductService>());
// });

final productBlockProvider =
    StateNotifierProvider<ProductBlockNotifier, ProductBlock>((ref) {
  return ProductBlockNotifier(ref);
});

// @injectable
class ProductBlockNotifier extends StateNotifier<ProductBlock> {
  ProductBlockNotifier(this.ref)
      : super(ProductBlock(productService: getIt.get<ProductService>()));

  final Ref ref;

  void addProd(item) {
    state.addToCart(item);
    // state.productService.myCart = [...state.productService.myCart, item];
  }

  void cleaning() => state.cleane();
  giveGoods() => state.goods();
  giveShow() => state.show();
  giveSum() => state.sum();
}

// @injectable
// class ProductBlock extends StateNotifier<ProductBlock> {
//   final ProductService productService = getIt.get<ProductService>();

// ProductBlock() :super()
// @immutable
@injectable
class ProductBlock {
  static int index = 0;
  final ProductService productService;
  ProductBlock({required this.productService}) {
    productService.createProducts(5);
    index++;
    print('index $index');
  }

  addToCart(item) {
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
