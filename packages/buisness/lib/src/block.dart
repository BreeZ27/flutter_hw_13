import 'dart:async';
import 'package:data/data.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productBlockProvider =
    StateNotifierProvider<ProductBlock, ProductService>((ref) {
  return ProductBlock();
});

@injectable
class ProductBlock extends StateNotifier<ProductService> {
  ProductBlock() : super(MyProductService());

  void addToCart(item) async {
    state.addToCart(item);
    state.give();
    print("BLOCK ADD");
  }

  void cleane() => state.cleane();

  void create(i) async {
    await state.createProducts(5);
  }

  goods() => state.store();

  show() => state.show();

  sum() {
    var _res = 0;
    for (var item in state.out.values) {
      _res += item;
    }
    _res *= 48;
    return _res;
  }
}
