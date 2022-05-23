import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:product_model/model.dart';

GetIt getIt = GetIt.instance;

// duplicate(ProductBlock inlet) {
//   ProductBlock _outlet = ProductBlock();
//   _outlet.productService.myCartStructured =
//       inlet.productService.myCartStructured;
//   _outlet.productService.products = inlet.productService.products;
//   _outlet.productService.myCart = inlet.productService.myCart;
//   return _outlet;
// }

// final productBlockProvider = Provider<ProductBlock>((ref) {
//   return ProductBlock(productService: getIt.get<ProductService>());
// });

final ProductBlock productBlock = ProductBlock();

final productsProvider =
    StateNotifierProvider<ProductBlockNotifier, Map<ProductData, int>>((ref) {
  return ProductBlockNotifier();
});

class ProductBlockNotifier extends StateNotifier<Map<ProductData, int>> {
  ProductBlockNotifier() : super({});

  Future<void> createProducts(int i) async {
    await productBlock.createProducts(5);
    state = {...productBlock.goods()};
  }
}

final cartProvider =
    StateNotifierProvider<CartNotifier, Map<ProductData, int>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<Map<ProductData, int>> {
  CartNotifier() : super({});

  Future<void> addProd(ProductData item) async {
    await productBlock.addToCart(item);
    state = {...productBlock.show()};
  }

  void clean() {
    productBlock.clean();
    state = {...productBlock.show()};
  }

  sum() {
    return productBlock.sum();
  }
}

@injectable
class ProductBlock {
  final ProductService productService = getIt.get<ProductService>();

  Future<void> createProducts(int i) async {
    await productService.createProducts(5);
  }

  Future<void> addToCart(item) async {
    productService.myCart.add(item);
    await productService.productsStructurer();
    print("addToCart productService.myCart: ${productService.myCart}");
    print(
        "addToCart productService.myCartStructured: ${productService.myCartStructured}");
  }

  void clean() {
    productService.clean();
    print('clean: ${productService.myCartStructured}');
  }

  void create(i) async {
    await productService.createProducts(5);
  }

  goods() {
    return productService.products;
  }

  show() => productService.myCartStructured;

  sum() {
    var _res = 0;
    for (var item in productService.myCartStructured.values) {
      _res += item;
    }
    _res *= 48;
    return _res;
  }
}
