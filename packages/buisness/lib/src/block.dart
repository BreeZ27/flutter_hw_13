import 'dart:async';
import 'package:data/data.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:product_model/model.dart';

GetIt getIt = GetIt.instance;

class ProductBlockClearAction {}

@immutable
class AppState {
  late final ProductBlock productBlock;

  AppState(ProductBlock block) {
    this.productBlock = block;
  }

  factory AppState.initial() => AppState(ProductBlock());

  AppState copyWith({
    required ProductBlock value,
  }) {
    return AppState(value);
  }
}

@injectable
class ProductBlock {
  final ProductService productService = getIt.get<ProductService>();

  ProductBlock() {
    print('ProductBlock created ${productService.hashCode}');
  }

  void addToCart(item) {
    productService.myCart.add(item);
    print('ProductBlock.addToCart(): ${productService.myCart}');
  }

  void createPrd(int value) {
    productService.createProducts(value);
  }

  void cleaning() {
    productService.myCart.clear();
    productService.out.clear();
  }

  give() async {
    await productService.give();
    print('ProductBlock.give(): ${productService.out}');
  }

  goods() {
    print('ProductBlock.goods(): ${productService.array}');
    return productService.array;
  }

  show() {
    print('ProductBlock.show(): ${productService.out}');
    return productService.out;
  }
}
